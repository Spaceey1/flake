{ ... }:

let
niriFiles = builtins.readDir ./mango/configs;

files =
builtins.concatStringsSep "\n"
(map
 (name: builtins.readFile (./mango/configs/${name}))
 (builtins.attrNames niriFiles)
 );
in {
	xdg.configFile."mango/config.conf".text = files;
}
