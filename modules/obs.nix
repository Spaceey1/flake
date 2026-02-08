{ pkgs, ... }:
{
  programs.obs-studio.enableVirtualCamera = true;
  environment.systemPackages = [
    pkgs.obs-studio
  ];
}
