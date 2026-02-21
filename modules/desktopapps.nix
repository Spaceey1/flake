{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    programs.desktopGroup.enable = lib.mkEnableOption "desktopAppGroup";
  };
  config = lib.mkIf config.programs.desktopGroup.enable {
    programs = {
      obs.enable = true;
      steam.enable = true;
      edhm.enable = true;
      niri.enable = true;
    };
    home-manager = {
      users."${config.host.mainUser}" = {
        programs = {
          hyprlock = {
            enable = true;
            mainMonitor = config.host.mainMonitor;
          };
          helix.enable = true;
          kitty = {
            nemoOpen = true;
            enable = true;
          };
          rofi.enable = true;
          fish.enable = true;
          fastfetch.enable = true;
          waybar.enable = true;
          dunst.enable = true;
          git.enable = true;
        };
        home.packages = [
          pkgs.element-desktop
        ];
      };
    };
  };
}
