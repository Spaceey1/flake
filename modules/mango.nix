{
  pkgs,
  lib,
  config,
  ...
}:

{
  environment.systemPackages = lib.mkIf config.programs.mango.enable (with pkgs; [
    grim
    slurp
  ]);
}
