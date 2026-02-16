{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}:

let
  colors = import ../colors.nix;
in
{
  config = lib.mkIf osConfig.host.isDesktopSystem {
    xdg.configFile."wleave/layout.json".text = ''
      	{
      		"buttons-per-row": "4",
      		"no-version-info": true,
      		"show-keybinds": true,
      		"margin-bottom": 350,
      		"margin-top": 350,
      		"buttons": [
      			{
      				"label": "lock",
      				"action": "${pkgs.hyprlock}/bin/hyprlock",
      				"text": "Lock",
      				"keybind": "l",
      				"icon": "${pkgs.wleave}/share/wleave/icons/lock.svg"
      			},
      			{
      				"label": "logout",
      				"action": "loginctl terminate-user $USER",
      				"text": "Logout",
      				"keybind": "e",
      				"icon": "${pkgs.wleave}/share/wleave/icons/logout.svg"
      			},
      			{
      				"label": "shutdown",
      				"action": "systemctl poweroff",
      				"text": "Shutdown",
      				"keybind": "s",
      				"icon": "${pkgs.wleave}/share/wleave/icons/shutdown.svg"
      			},
      			{
      				"label": "reboot",
      				"action": "systemctl reboot",
      				"text": "Reboot",
      				"keybind": "r",
      				"icon": "${pkgs.wleave}/share/wleave/icons/reboot.svg"
      			}
      		],
      		"css": "${config.home.homeDirectory}/.config/wleave/style.css"
      	}
      	'';
    xdg.configFile."wleave/style.css".text = ''
          *{
            all:unset;
            background-color: rgba(${colors.palette.background.rgbRaw}, 0.6);
          }
      		window {
      			background-color: rgba(${colors.palette.background.rgbRaw}, 0.6);
      		}
      		
      		button {
      			color: ${colors.palette.text.hex};
      			background-color: ${colors.palette.background.hex};
      			border: 1px ${colors.palette.primary.hex} solid;
      			border-radius: 8px;
      			padding: 10px;
      		}
      		
      		button label.action-name {
      			font-size: 24px;
      		}
      		
      		button label.keybind {
      			color: ${colors.palette.primary.hex};
      			font-size: 20px;
      			font-family: monospace;
      		}
      		button:active {
      		}
      	'';
  };
}
