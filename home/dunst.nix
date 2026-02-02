{ osConfig, ... }:

let
  colors = import ./colors.nix;
  in
{
  xdg.configFile."dunst/dunstrc".text = ''
    		[global]
    		corner_radius = 8
    		frame_width = 1
    		frame_color = "${colors.magenta.hex}"
    		background = "${colors.black.hex}"
    		monitor = "${osConfig.host.mainMonitor}"
    		history_length = 0
    		origin=top-right
    		offset=(30,15)
    		height = (50, 250)
    		notification_limit = 2
    		format="<b>%s</b>\n%b"
    	'';
}
