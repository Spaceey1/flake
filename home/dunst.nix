{ ... }:

{
  xdg.configFile."dunst/dunstrc".text = ''
    		[global]
    		corner_radius = 8
    		frame_width = 1
    		frame_color = "#b37becff"
    		background = "#131313"
    		monitor = "HDMI-A-2"
    		history_length = 0
    		origin=top-right
    		offset=(30,15)
    		height = (50, 250)
    		notification_limit = 2
    		format="<b>%s</b>\n%b"
    	'';
}
