{
  pkgs,
  config,
  lib,
  ...
}:

let
  niriFiles = builtins.readDir ./niri/configs;
  niriConfig = builtins.concatStringsSep "\n" (
    map (name: builtins.readFile (./niri/configs/${name})) (builtins.attrNames niriFiles)
  );
  colors = import ./colors.nix;
in
{
  imports = [
    ./niri/animations.nix
    ./niri/binds.nix
  ];
  options.programs.niri = {
    wallpaper = lib.mkOption {
      description = "path to wallpaper";
      type = lib.types.path;
    };
  };
  config = {
    xdg.configFile."niri/config.kdl".text = ''
      spawn-at-startup "${pkgs.dunst}/bin/dunst"
      spawn-at-startup "${pkgs.waybar}/bin/waybar" "-c" "${config.home.homeDirectory}/.config/waybar/config-niri.jsonc"
      spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-i" "${config.programs.niri.wallpaper}"
      spawn-at-startup "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      spawn-at-startup "${pkgs.hyprlock}/bin/hyprlock"

      layout {
      	struts{
      		left 16
      		right 16
      	}
      	gaps 8

      	preset-column-widths {
      		proportion 0.33333
      		proportion 0.5
      		proportion 0.66667
      	}

      	default-column-width { proportion 0.50; }

      	focus-ring {
      		width 1
      		active-color "${colors.magenta.hex}"
      		inactive-color "${colors.gray.hex}"
      	}
      	border {
      		off

      		width 4
      		active-color "${colors.magenta.hex}"
      		inactive-color "${colors.gray.hex}"
      		urgent-color "${colors.red.hex}"
      	}
      	background-color "transparent"
      	
      }
      cursor {
          xcursor-theme "phinger-cursors-light"
          xcursor-size 24
      }
      ${niriConfig}
      '';
  };
}
