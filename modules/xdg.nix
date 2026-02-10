{ pkgs, config, ... }:

let
  desktopEntries = {
    nemo = {
      name = "Nemo";
      exec = "${pkgs.nemo-with-extensions}/bin/nemo";
      desktop = "nemo.desktop";
    };
    feh = {
      name = "Feh";
      exec = "${pkgs.feh}/bin/feh";
      desktop = "feh.desktop";
    };
    Helix = {
      name = "Helix";
      exec = "${config.programs.helix.package}/bin/hx";
      desktop = "Helix.desktop";
      terminal = true;
    };
  };
  xdg-terminal-exec =
    pkgs.runCommand "xdg-terminal-exec"
      {
      }
      ''
        mkdir -p $out/bin
        ln -s ${pkgs.kitty}/bin/kitty $out/bin/xdg-terminal-exec
      '';
in
{
  config = {
    xdg.desktopEntries = builtins.mapAttrs (_: entry: {
      name = entry.name;
      exec = entry.exec;
      terminal = entry.terminal or false;
      noDisplay = true;
    }) desktopEntries;
    dconf = {
      settings = {
        "org/cinnamon/desktop/applications/terminal" = {
          exec = "${pkgs.kitty}/bin/kitty";
          exec-arg = " "; # argument
        };
        "org/gnome/desktop/applications/terminal" = {
          exec = "${pkgs.kitty}/bin/kitty";
        };
      };
    };
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ desktopEntries.nemo.desktop ];
        "application/x-gnome-saved-search" = [ desktopEntries.nemo.desktop ];
        "image/*" = [ desktopEntries.feh.desktop ];
        "text/*" = [ desktopEntries.Helix.desktop ];
      };
    };
    home.packages = [
      xdg-terminal-exec
    ];
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gnome # the screensharing necessary evil
      ];
      config = {
        common = {
          default = [
            "gtk"
            "wlr"
            "gnome"
          ];
        };
        niri = {
          default = [
            "gtk"
            "gnome"
          ];
        };
      };
    };
  };
}
