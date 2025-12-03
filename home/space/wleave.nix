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
				"action": "hyprlock",
				"text": "Lock",
				"keybind": "l",
				"icon": "${pkgs.wleave}/share/wleave/icons/lock.svg"
			},
			{
				"label": "logout",
				"action": "niri msg action quit",
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
}
