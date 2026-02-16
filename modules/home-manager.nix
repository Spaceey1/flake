{
  inputs,
  lib,
  config,
  ...
}:
{
  config = {
    home-manager = {
      useGlobalPkgs = true;
      sharedModules =
        builtins.map (name: ../home + "/${name}") (
          builtins.attrNames (
            lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) (
              builtins.readDir ../home
            )
          )
        )
        ++ [({...}: {
          home.stateVersion = "26.05";
        })];
    };
  };
}
