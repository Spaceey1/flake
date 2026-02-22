{
  inputs,
  config,
  system,
  lib,
  pkgs,
  ...
}:
{
  options.programs.overte = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.programs.overte.enable {
    environment.systemPackages = [
      pkgs.overte-bin
    ];
  };
}
