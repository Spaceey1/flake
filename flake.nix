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
              (hostsDir + "/${filename}")
              ./modules/base.nix
            ];
          }
        );
    in
    {
      nixosConfigurations = lib.mapAttrs' mkHost nixFiles;
    };
}
