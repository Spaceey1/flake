{ pkgs, ... }:
let
  iconTheme = {
    package = pkgs.mint-y-icons;
    name = "Mint-Y-Dark-Purple";
  };
  theme = {
    package = pkgs.mint-themes;
    name = "Mint-Y-Dark-Purple";
  };
  cursorTheme = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 24;
  };
  colorScheme = "dark";
in
{
  gtk = {
    enable = true;
    inherit iconTheme;
    inherit cursorTheme;
    inherit colorScheme;
    inherit theme;
    gtk2 = {
      inherit iconTheme;
      inherit cursorTheme;
      inherit theme;
    };
    gtk3 = {
      inherit iconTheme;
      inherit cursorTheme;
      inherit colorScheme;
      inherit theme;
    };
    gtk4 = {
      enable = false;
      # inherit iconTheme;
      # inherit cursorTheme;
      # inherit colorScheme;
      # inherit theme; # assholes break themes
    };
  };
}
