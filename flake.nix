{
	description = "My NixOS config (multi-module)";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};
	
	outputs = { self, nixpkgs, nixpkgs-xr, nixpkgs-unstable, home-manager, ... }:
	
	let
	system = "x86_64-linux";
	pkgsUnstable = import nixpkgs-unstable {
		inherit system;
		config.allowUnfree = true;
	};
	in {
		nixosConfigurations.puputer = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ 
				./hosts/puputer.nix
				home-manager.nixosModules.home-manager
			];
			specialArgs = {
				inherit nixpkgs-xr;
				inherit pkgsUnstable;
			};
		};
		
	};
}
