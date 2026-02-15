{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.programs.steam.enable {
    hardware.steam-hardware.enable = true;
    programs.gamescope.enable = true;
    environment.systemPackages = with pkgs; [
      r2modman
      mangohud
      lutris
      prismlauncher
    ];
  };
}
