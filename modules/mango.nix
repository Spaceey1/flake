{ pkgs, pkgsUnstable, ... }:

{
  programs.mango.enable = true;
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-wlr
    grim
    slurp
  ];
}
