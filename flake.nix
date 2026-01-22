{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-xr,
      nixpkgs-unstable,
      home-manager,
      mango,
      ...
    }:

    let
      system = "x86_64-linux";
      pkgsUnstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.puter = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/puter.nix
          home-manager.nixosModules.home-manager
          mango.nixosModules.mango
        ];
        specialArgs = {
          inherit nixpkgs-xr;
          inherit pkgsUnstable;
        };
      };
      nixosConfigurations.lap = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/lap.nix
          home-manager.nixosModules.home-manager
          mango.nixosModules.mango
        ];
        specialArgs = {
          inherit nixpkgs-xr;
          inherit pkgsUnstable;
        };
      };
    };
}
