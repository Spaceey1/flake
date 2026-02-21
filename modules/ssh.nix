{ lib, config, ... }:
{
  options.services.openssh.autostart = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
  config = {
    services.openssh.enable = true;
    systemd.services.sshd.wantedBy = lib.mkIf (!config.services.openssh.autostart) (lib.mkForce [ ]);
  };
}
