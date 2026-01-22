{
  config,
  lib,
  nixpkgs-xr,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    nixpkgs-xr.overlays.default
    (final: prev: {
      # Fix for "File already exists in database" crash at startup
      monado = prev.monado.overrideAttrs (old: {
        buildInputs = builtins.filter (x: x != prev.opencv) old.buildInputs;
        cmakeFlags = (old.cmakeFlags or [ ]) ++ [
          "-DBUILD_WITH_OPENCV=OFF"
        ];
      });
    })
    (final: prev: {
      wlx-overlay-s = pkgs.rustPlatform.buildRustPackage (old: {
        src = final.fetchFromGitHub {
          owner = "wlx-team";
          repo = "wayvr";
          rev = "main";
          sha256 = "sha256-MSfpZPZdezS4rtt1W1YgJusMuPxRLrkBCRvJfn8lnfE=";
        };
        pname = "wlx-overlay-s";
        version = "latest";
        cargoHash = "sha256-zqB2ybdpQEGdlkNin6mlUfaVRkpOtFl2CVCLAdKDMoQ=";
        SHADERC_LIB_DIR = "${pkgs.shaderc.lib}/lib";
        nativeBuildInputs = [
          pkgs.pkg-config
          pkgs.rustPlatform.bindgenHook
          pkgs.cmake
          pkgs.shaderc
          pkgs.makeWrapper
        ];
        buildInputs = [
          pkgs.openssl
          pkgs.alsa-lib
          pkgs.pipewire
          pkgs.libclang
          pkgs.cmake
          pkgs.shaderc
          pkgs.wayland
          pkgs.libxkbcommon
          pkgs.vulkan-loader
          pkgs.libGL
          pkgs.dbus
          pkgs.openxr-loader
          pkgs.openvr
          pkgs.xorg.libX11
          pkgs.xorg.libXext
          pkgs.xorg.libXrandr
          pkgs.xorg.libxcb
        ];
      });
    })

  ];
  environment.systemPackages = with pkgs; [
    xrizer
    wlx-overlay-s
  ];
  my.python.packages = lib.mkAfter (
    with pkgs.python3Packages;
    [
      watchdog
      requests
      websockets
    ]
  );
  services.monado = {
    enable = true;
    defaultRuntime = true;
    forceDefaultRuntime = true;
    highPriority = true;
    package = pkgs.monado;
  };
  systemd.user.services = {
    monado = {
      environment = {
        STEAMVR_LH_ENABLE = "1";
        XRT_COMPOSITOR_COMPUTE = "1";
        XRT_COMPOSITOR_USE_PRESENT_WAIT = "1";
        U_PACING_COMP_TIME_FRACTION_PERCENT = "90";
        XRT_COMPOSITOR_FORCE_WAYLAND_DIRECT = "1";
        XRT_DEBUG_GUI = "1";
      };
      serviceConfig = {
        TimeoutStopSec = 1;
        KillSignal = "SIGKILL";
      };
    };
    wlx-overlay-s = {
      description = "VR wlx-overlay-s";
      path = [ pkgs.wlx-overlay-s ];
      serviceConfig = {
        ExecStart = "${pkgs.wlx-overlay-s}/bin/wayvr";
        Restart = "on-abnormal";
      };
      bindsTo = [ "monado.service" ];
      partOf = [ "monado.service" ];
      after = [ "monado.service" ];
      upheldBy = [ "monado.service" ];
      unitConfig.ConditionUser = "!root";
    };
  };
  home-manager.users.space.xdg.configFile."openvr/openvrpaths.vrpath" = {
    text = ''
      		{
      			"config" :
      				[
      				"/home/space/.local/share/Steam/config"
      				],
      				"external_drivers" : null,
      				"jsonid" : "vrpathreg",
      				"log" :
      					[
      					"/home/space/.local/share/Steam/logs"
      					],
      					"runtime" :
      						[
      						"${pkgs.xrizer}/lib/xrizer"
      						],
      						"version" : 1
      		}
      		'';
    force = true;
  };
  home-manager.users.space.xdg.configFile."openxr/1/active_runtime.json" = {
    source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";
    force = true;
  };

  environment.sessionVariables = {
    IPC_IGNORE_VERSION = "1";
    #PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES = "1";
  };
}
