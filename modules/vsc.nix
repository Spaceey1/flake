{ pkgs, ... }:

{
  #programs.vscode = {
  #	package = pkgsUnstable.vscode;
  #	enable = true;
  #	extensions = with pkgsUnstable.vscode-extensions; [
  #		bbenoist.nix
  #		golang.go
  #		twxs.cmake
  #	];

  #};
  environment.systemPackages = [
    pkgs.vscode
  ];
}
