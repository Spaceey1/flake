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
          pkgs.easyeffects
          pkgs.element-desktop
          pkgs.teamspeak6-client
          pkgs.wget
          pkgs.librewolf
          pkgs.kitty
          pkgs.swaybg
          pkgs.eww
          pkgs.equibop
          pkgs.wl-clipboard
          pkgs.xwayland-satellite
          pkgs.spotifywm
          pkgs.spicetify-cli
          pkgs.playerctl
          pkgs.fastfetch
          pkgs.zoxide
          pkgs.wleave
          pkgs.pwvucontrol
          pkgs.btop-cuda
          pkgs.hyprlock
          pkgs.nemo
          pkgs.jq
          pkgs.dunst
          pkgs.libnotify
          pkgs.ffmpeg
          pkgs.yt-dlp
          pkgs.mpv
          pkgs.telegram-desktop
          pkgs.feh
          pkgs.qpwgraph
          pkgs.unzip
          pkgs.unrar
          pkgs.openssh
          pkgs.gparted
          pkgs.qbittorrent
          pkgs.qalculate-gtk
          pkgs.baobab
          pkgs.pinta
        ]
        ++ lib.optional config.host.hasBattery pkgs.powertop;
      };
    };
  };
}
