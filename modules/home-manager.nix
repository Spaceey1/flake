{
  inputs,
  lib,
  config,
  ...
}:
{
  options = {
    host.homeManager.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = {
    home-manager.users."${config.host.mainUser}" = lib.mkIf config.host.homeManager.enable (
      import ../home/home.nix
    );
    home-manager.useGlobalPkgs = true;
  };
}
