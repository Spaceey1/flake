{ inputs, config, ... }:
{
  home-manager = {
    users."${config.host.mainUser}" = import ../home/home.nix;
    useGlobalPkgs = true;
  };
}
