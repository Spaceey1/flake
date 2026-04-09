{ osConfig, pkgs, config, lib, ... }:
let
  sharedConfig = ''
    "battery": {
    	"format": "{capacity}% {icon}  ",
    	"format-icons": ["", "", "", "", ""]
    },
    "layer": "top"
  '';
  colors = osConfig.theme;
in
{
  config = lib.mkIf config.programs.waybar.enable {
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
          "custom#overview": {
            "on-click": "niri msg action toggle-overview"
          },
          "modules-right": [
    		      ${if (osConfig.host.hasBattery) then ''"battery",'' else ""}
    		      "tray",
    		      "clock",
    		      "custom#overview"
    	    ],
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

          "modules-right": [
          		${if (osConfig.host.hasBattery) then ''"battery",'' else ""}
          		"tray",
          		"clock"
          	],
      		${sharedConfig}
      	}
      	'';
    xdg.configFile."waybar/style.css".text = ''
      		#waybar {
      			background-color: ${colors.palette.background.hex};
      			color: ${colors.palette.text.hex};
      			font-family: "Commit Mono Nerd Font";
      		}
      		#workspaces button {
      			padding: 0 5px;
      			color: ${colors.palette.primary.hex};
      			background: transparent;
      			border-bottom: 2px solid transparent;
      		}
      		/* Active tag (viewed) */
      		#workspaces button.active {
      			color: ${colors.palette.background.hex};
      			background-color: ${colors.palette.primary.hex};
      			border-radius: 4px;
      		}
      		
      		/* Tag with windows but not focused */
      		#workspaces button.occupied {
      			color: ${colors.palette.primary.hex};
      		}
      		/* Tag requesting attention */
      		#workspaces button.urgent {
      			background-color: ${colors.baseColors.red.hex};
      			color: ${colors.palette.background.hex};
      		}
      		#clock {
      			padding: 0px 10px;
      		}
      		#custom.overview{
      		  min-width: 5px;
      		  background-color: ${colors.palette.primary.hex};
      		}
      	'';
    home.packages = with pkgs; [
      nerd-fonts.commit-mono
      waybar
    ];
  };
}
