final: prev:
let
  inherit (prev) lib;
  packageFiles = builtins.readDir ../pkgs;
  callPackageFile =
    filename: type:
    let
      packageName = lib.removeSuffix ".nix" filename;
      inherit filename;
    in
    lib.nameValuePair packageName (final.callPackage (../pkgs/${filename}) { });
in
lib.mapAttrs' callPackageFile packageFiles
