{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    programs.obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.programs.obs.enable {
    programs.obs-studio.enableVirtualCamera = true;
    environment.systemPackages = [
      pkgs.obs-studio
    ];
  };
}
