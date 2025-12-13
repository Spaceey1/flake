{ pkgs, ... }:

{
	programs.vscode = {
		package = pkgs.vscode-fhs;
		enable = true;
		extensions = with pkgs.vscode-extensions; [
			bbenoist.nix
			golang.go
			twxs.cmake
		];

	};
}
