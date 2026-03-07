{
  osConfig,
  pkgs,
  config,
  lib,
  ...
}:
let
  colors = osConfig.theme;
in
{
  options = {
    programs.fish.promptColor = lib.mkOption {
      type = lib.types.str;
      default = colors.palette.primary.hex;
      description = "The color of the prompt";
    };
  };
  config = {
    programs.fish = lib.mkIf config.programs.fish.enable {

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
          				string join ' ' -- (set_color -b "${config.programs.fish.promptColor}") (prompt_pwd) (set_color normal) ':3 '
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

        fish_greeting = lib.mkIf config.programs.fastfetch.enable ''
          ${pkgs.fastfetch}/bin/fastfetch
        '';
        nixre = ''
          if sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nix#${osConfig.networking.hostName}
            ${pkgs.libnotify}/bin/notify-send "NixOS rebuild" "Success"
          else
             ${pkgs.libnotify}/bin/notify-send "NixOS rebuild" "Fail"       
          end
        '';
        openminecraft = ''
          sudo iptables -I INPUT -p tcp --dport 25565 -j ACCEPT
        '';
        closeminecraft = ''
          sudo iptables -D INPUT -p tcp --dport 25565 -j ACCEPT
        '';
        ns = ''
          nix-shell -p $argv
        '';
      };
    };

    # Required runtime dependencies
    home.packages = with pkgs; [
      zoxide
      skim
      mlocate
    ];
  };
}
