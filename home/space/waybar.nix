{ hostName, pkgs, ... }:
let
sharedConfig = ''
"battery": {
	"format": "{capacity}%  "
},
"layer": "top",
"modules-right": [
		${if (hostName == "lap") then
		''"battery",''
		else
		""}
		"tray",
		"clock"
	]
'';
in
{
	xdg.configFile."waybar/config-niri.jsonc".text = ''
	{
		"modules-left": [
			"niri/workspaces"
		],
		
		"modules-center": [
			"niri/window"
		],
		"niri/window": {
			"format": "{title}"
		},
		${sharedConfig}
	}
	'';
	xdg.configFile."waybar/config-mango.jsonc".text = ''
	{
		"modules-left": [
			"ext/workspaces",
		],
		"modules-center": [
			"dwl/window",
		],
		"ext/workspaces": {
			"format": "{icon}",
			"ignore-hidden": true,
			"on-click": "activate",
			"on-click-right": "deactivate",
			"sort-by-id": true
		},
		"dwl/window": {
			"format": "{title}"
		},
		${sharedConfig}
	}
	'';
	xdg.configFile."waybar/style.css".text = ''
		#waybar {
			background-color: #131313;
			color: white;
			font-family: "Commit Mono Nerd Font"
		}
		#workspaces button {
			padding: 0 5px;
			color: #9342e4;
			background: transparent;
			border-bottom: 2px solid transparent;
		}
		/* Active tag (viewed) */
		#workspaces button.active {
			color: #131313;
			background-color: #9342e4;
			border-radius: 4px;
		}
		
		/* Tag with windows but not focused */
		#workspaces button.occupied {
			color: #cdc885;
		}
		/* Tag requesting attention */
		#workspaces button.urgent {
			background-color: #ef5e5e;
			color: #282828;
		}
		#clock {
			padding: 0px 10px;
		}
	'';
	home.packages = with pkgs; [
		nerd-fonts.commit-mono
		waybar
	];
}
