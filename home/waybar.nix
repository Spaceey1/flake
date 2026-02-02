{ osConfig, pkgs, ... }:
let
  sharedConfig = ''
    "battery": {
    	"format": "{capacity}% {icon}  ",
    	"format-icons": ["", "", "", "", ""]
    },
    "layer": "top",
    "modules-right": [
    		${if (osConfig.host.hasBattery) then ''"battery",'' else ""}
    		"tray",
    		"clock"
    	]
  '';
  colors = import ./colors.nix;
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
    			background-color: ${colors.black.hex};
    			color: ${colors.white.hex};
    			font-family: "Commit Mono Nerd Font"
    		}
    		#workspaces button {
    			padding: 0 5px;
    			color: ${colors.magenta.hex};
    			background: transparent;
    			border-bottom: 2px solid transparent;
    		}
    		/* Active tag (viewed) */
    		#workspaces button.active {
    			color: ${colors.black.hex};
    			background-color: ${colors.magenta.hex};
    			border-radius: 4px;
    		}
    		
    		/* Tag with windows but not focused */
    		#workspaces button.occupied {
    			color: ${colors.magenta.hex};
    		}
    		/* Tag requesting attention */
    		#workspaces button.urgent {
    			background-color: ${colors.red.hex};
    			color: ${colors.black.hex};
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
