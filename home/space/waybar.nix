{ ... }:

{
	xdg.configFile."waybar/config.jsonc".text = ''
	{
		"modules-left": [
			"ext/workspaces",
			"niri/workspaces"
		],
		"modules-right": [
			"clock"
		],
		"modules-center": [
			"dwl/window",
			"niri/window"
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
		"layer": "top"
	}
	'';
	xdg.configFile."waybar/style.css".text = ''
	#waybar {
		background-color: #131313;
		color: white;
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
}
