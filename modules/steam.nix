{ pkgs, config, ... }:

{
	hardware.steam-hardware.enable = true;
	programs.steam.enable = true;
	programs.gamescope.enable = true;
}
