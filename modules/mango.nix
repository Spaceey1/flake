{ pkgs, pkgsUnstable, ... }:

{
	mango = {
		url = "github:DreamMaoMao/mango";
		inputs.nixpkgs.follows = "nixpkgs";
	};
        programs.mango.enable = true;
}
