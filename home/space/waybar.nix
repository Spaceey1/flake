{}:

{
	xdg.configFile."waybar/config.jsonc" = ''
	{
		"modules-left": [
			"ext/workspaces",
			"dwl/window"
		],
		"ext/workspaces": {
			"format": "{icon}",
			"ignore-hidden": true,
			"on-click": "activate",
			"on-click-right": "deactivate",
			"sort-by-id": true
		},
		"dwl/window": {
			"format": "[{layout}] {title}"
		}
	}
	'';
	xdg.configFile."waybar/style.css" = ''
	#workspaces button {
		padding: 0 5px;
		color: #ddca9e;
		background: transparent;
		border-bottom: 2px solid transparent;
	}
	/* Active tag (viewed) */
	#workspaces button.active {
		color: #282828;
	       background-color: #ddca9e;
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
'';
}
