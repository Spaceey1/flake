{
  inputs,
  config,
  system,
  lib,
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
      inputs.overte.packages."${system}".overte-full
    ];
  };
}
