{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "pkgs";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "pkgs";
    };
    import-tree.url = "github:vic/import-tree";
    edhm = {
      url = "github:Spaceey1/EDHM-Nix";
      inputs.nixpkgs.follows = "pkgs";
    };
  };

  outputs =
    inputs:
    let
      lib = inputs.pkgs.lib;
      hostsDir = ./hosts;
      dirContents = builtins.readDir hostsDir;
      isNixFile = name: type: type == "regular" && lib.hasSuffix ".nix" name;
      nixFiles = lib.filterAttrs isNixFile dirContents;
      mkHost =
        filename: type:
        let
          hostname = lib.removeSuffix ".nix" filename;
        in
        lib.nameValuePair hostname (
          lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
              inherit hostname;
            };
            modules = [
              inputs.home-manager.nixosModules.home-manager
              inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
              inputs.edhm.nixosModules.default
              inputs.mango.nixosModules.mango
              (hostsDir + "/${filename}")
              (hostsDir + "/hardware/${filename}")
              (inputs.import-tree ./modules)
            ];
          }
        );
    in
    {
      nixosConfigurations = lib.mapAttrs' mkHost nixFiles;
    };
}
