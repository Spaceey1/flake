{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.programs.unity = {
    enable = lib.mkEnableOption "unity";
  };
  config = lib.mkIf config.programs.unity.enable {
    environment.systemPackages = [ pkgs.unityhub pkgs.p7zip ];
  };
}
