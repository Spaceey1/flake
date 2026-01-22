{ pkgs, ... }:

{
  config = {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    environment.systemPackages = [
      pkgs.qemu
      pkgs.virtiofsd
    ];
  };
}
