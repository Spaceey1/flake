{ pkgs, ... }:

{
  programs.mango.enable = true;
  environment.systemPackages = with pkgs; [
    grim
    slurp
  ];
}
