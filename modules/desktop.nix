{
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./python.nix
  ];
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.niri}/bin/niri-session";
        user = config.host.mainUser;
      };
      default_session = initial_session;
    };
  };
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  

  security.polkit.enable = true;
  programs.nix-ld.enable = true;
  xdg.icons.fallbackCursorThemes = [ "phinger-cursors-light" ];
  services.locate.enable = true;
  services.locate.package = pkgs.plocate;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    PROTON_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
