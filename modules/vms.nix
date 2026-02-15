{ pkgs, lib, config, ... }:

{
  config = lib.mkIf config.virtualisation.libvirtd.enable {
    programs.virt-manager.enable = config.host.isDesktopSystem;
    environment.systemPackages = [
      pkgs.qemu
      pkgs.virtiofsd
    ];
  };
}
