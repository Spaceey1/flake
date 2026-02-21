{
  pkgs,
  lib,
  config,
  ...
}:

let
  # example.com
  rootDomain = config.networking.domain;
  # matrix.example.com
  matrixSub = "matrix.${rootDomain}";
  # turn.example.com
  turnSub = "turn.${rootDomain}";

  mkWellKnown = data: ''
    default_type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
  clientConfig."m.homeserver".base_url = matrixSub;
  serverConfig."m.server" = "${matrixSub}:443";
in
{
  config = lib.mkIf config.services.matrix-synapse.enable {
    # 1. Database
    services.postgresql = {
      enable = true;
      initialScript = pkgs.writeText "synapse-init.sql" ''
        CREATE ROLE "matrix-synapse" WITH LOGIN;
        CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
          TEMPLATE template0
          LC_COLLATE = "C"
          LC_CTYPE = "C";
      '';
    };

    # 2. ACME Global Settings
    security.acme = {
      acceptTerms = true;
      defaults.email = "admin@${rootDomain}";
    };

    # 3. Nginx
    services.nginx = {
      enable = true;
      virtualHosts = {
        # The Identity Domain (example.com)
        "${rootDomain}" = {
          enableACME = true;
          forceSSL = true;
          # Only discovery files live here
          locations."= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
          locations."= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
          locations."/".extraConfig = "return 404;";
        };

        # The Service Domain (matrix.example.com)
        "${matrixSub}" = {
          enableACME = true;
          forceSSL = true;
          locations."/_matrix".proxyPass = "http://[::1]:8008";
          locations."/_synapse/client".proxyPass = "http://[::1]:8008";
        };

        # The TURN Domain (turn.example.com)
        "${turnSub}" = {
          enableACME = true;
          forceSSL = true;
          locations."/".extraConfig = "return 404;";
        };
      };
    };

    # 4. Matrix Synapse
    services.matrix-synapse = {
      enable = true;
      extraConfigFiles = [ "/var/lib/secrets/synapse-secrets.yaml" ];
      settings = {
        server_name = rootDomain;
        public_baseurl = "https://${matrixSub}";
        turn_uris = [
          "turn:${turnSub}:3478?transport=udp"
          "turn:${turnSub}:3478?transport=tcp"
        ];

        listeners = [
          {
            port = 8008;
            bind_addresses = [
              "127.0.0.1"
              "::1"
            ];
            type = "http";
            tls = false;
            x_forwarded = true;
            resources = [
              {
                names = [
                  "client"
                  "federation"
                ];
                compress = true;
              }
            ];
          }
        ];

        #a

        database = {
          name = "psycopg2";
          allow_unsafe_locale = true;
          args = {
            user = "matrix-synapse";
            database = "matrix-synapse";
            host = "/run/postgresql";
          };
        };

        enable_registration = false;
        url_preview_enabled = true;
        enable_metrics = false;

      };
    };

    # 5. Coturn
    services.coturn = {
      enable = true;
      realm = turnSub;
      use-auth-secret = true;
      static-auth-secret-file = "/var/lib/secrets/turn-secret";
      cert = "/var/lib/acme/${turnSub}/full.pem";
      pkey = "/var/lib/acme/${turnSub}/key.pem";
    };

    # 6. Permissions & Firewall
    users.users.turnserver.extraGroups = [ "acme" ];
    networking.firewall = {
      allowedTCPPorts = [
        80
        443
        3478
        5349
      ];
      allowedUDPPorts = [
        3478
        5349
      ];
      allowedUDPPortRanges = [
        {
          from = 49152;
          to = 65535;
        }
      ];
    };
    systemd.services.matrix-setup-everything = {
      description = "Generate secrets and ensure database exists";
      # Ensure this runs after Postgres but before Synapse
      after = [ "postgresql.service" ];
      before = [
        "matrix-synapse.service"
        "coturn.service"
      ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "oneshot";
      script = ''
                          # --- Part A: Secret Generation ---
                          mkdir -p /var/lib/secrets
                          if [ ! -f /var/lib/secrets/turn-secret ]; then
                            ${pkgs.openssl}/bin/openssl rand -hex 32 > /var/lib/secrets/turn-secret
                          fi
                          if [ ! -f /var/lib/secrets/registration-secret ]; then
                            ${pkgs.openssl}/bin/openssl rand -hex 32 > /var/lib/secrets/registration-secret
                          fi

                          TURN_SECRET=$(cat /var/lib/secrets/turn-secret)
                          REG_SECRET=$(cat /var/lib/secrets/registration-secret)

                          cat <<EOF > /var/lib/secrets/synapse-secrets.yaml
              turn_shared_secret: "$TURN_SECRET"
              registration_shared_secret: "$REG_SECRET"
        EOF
                          
              chown root:turnserver /var/lib/secrets/turn-secret
              chown root:matrix-synapse /var/lib/secrets/synapse-secrets.yaml
              chmod 440 /var/lib/secrets/*
              chmod 755 /var/lib/secrets

      '';
    };
    users.users."${config.host.mainUser}".extraGroups = [
      "keys"
      "matrix-synapse"
    ];
  };
}
