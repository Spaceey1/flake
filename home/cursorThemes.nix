{
  pkgs,
  osConfig,
  lib,
  ...
}:

{
  config = lib.mkIf osConfig.host.isDesktopSystem {
    home.file.".local/share/icons/default" = {
      source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors-light/";
      recursive = true;
    };
  };
}
