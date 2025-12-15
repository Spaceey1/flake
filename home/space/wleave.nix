{ config, pkgs, ...}:

{
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
		]
	}
	'';
	xdg.configFile."wleave/style.css".text = ''
		:root{
			--view-bg-color: #131313;
			--view-fg-color: #131313;
		
		}
		window {
			background-color: rgba(13, 13, 13, 0.6);
		}
		
		button {
			color: #bbbbbb;
			background-color: var(--view-bg-color);
			border: 1px #b37bec solid;
			border-radius: 8px;
			padding: 10px;
		}
		
		button label.action-name {
			font-size: 24px;
		}
		
		button label.keybind {
			color: #b37bec;
			font-size: 20px;
			font-family: monospace;
		}
		
		button:active {
		    color: var(--accent-fg-color);
		    background-color: var(--accent-bg-color);
		}
	'';
}
