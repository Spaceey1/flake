{ ... }:

let
niriFiles = builtins.readDir ./niri/configs;

files =
builtins.concatStringsSep "\n"
(map
 (name: builtins.readFile (./niri/configs/${name}))
 (builtins.attrNames niriFiles)
 );
in {
	imports = [ ./niri/animations.nix ];
	xdg.configFile."niri/config.kdl".text = files;
}
