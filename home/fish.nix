{ config, pkgs, hostName, ... }:

{
	programs.fish = {
		enable = true;

		shellAliases = {
			cd = "z";
		};

		interactiveShellInit = ''
			# zoxide
			${pkgs.zoxide}/bin/zoxide init fish | source
		'';

		functions = {
			parentdir = ''
				set p $argv[1]
				if test -d "$p"
					echo (realpath "$p")
				else
					dirname (realpath "$p")
						end
			'';
			fish_prompt = ''
				string join ' ' -- (set_color -b 009999) (prompt_pwd) (set_color normal) ':3 '
			'';

			cf = ''
				set -l pick (locate -i -- $argv | ${pkgs.skim}/bin/sk)
				test -z "$pick"; and return
				set -l path (realpath -- "$pick")
				if test -d "$path"
					cd "$path"
						commandline -r -- ""
						return
						end
						cd (parentdir "$path")
						set -l name (basename -- "$path")
						commandline -r -- (string escape -- "$name")
						commandline -C 0
			''; 

			fish_greeting = ''
				${pkgs.fastfetch}/bin/fastfetch
			'';

			nixre = ''
				sudo nixos-rebuild switch --flake /home/space/nix#${hostName}
			'';
			openminecraft = ''
				sudo iptables -I INPUT -p tcp --dport 25565 -j ACCEPT
			'';
			closeminecraft = ''
				sudo iptables -D INPUT -p tcp --dport 25565 -j ACCEPT
			'';
		};
	};

# Required runtime dependencies
	home.packages = with pkgs; [
		zoxide
		fastfetch
		skim
		mlocate
	];
}
