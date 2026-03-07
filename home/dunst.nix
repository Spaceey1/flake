{
  osConfig,
  lib,
  config,
  pkgs,
  ...
}:

let
  colors = osConfig.theme;
in
{
  options.programs.dunst = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.programs.dunst.enable {
    home.packages = [ pkgs.dunst ];
    xdg.configFile."dunst/dunstrc".text = ''
      		[global]
      		corner_radius = 8
      		frame_width = 1
      		frame_color = "${colors.palette.primary.hex}"
      		background = "${colors.palette.background.hex}"
      		monitor = "${osConfig.host.mainMonitor}"
      		history_length = 0
      		origin=top-right
      		offset=(30,15)
      		height = (50, 250)
      		notification_limit = 2
      		format="<b>%s</b>\n%b"
      	'';
  };
}
