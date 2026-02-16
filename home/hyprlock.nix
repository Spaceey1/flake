{ lib, config, ... }:
{

  options.programs.hyprlock = {
    lockImage = lib.mkOption {
      description = "Lock image";
      type = lib.types.nullOr lib.types.path;
      default = null;
    };
    mainMonitor = lib.mkOption {
      description = "Primary monitor";
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
  };

  config = lib.mkIf config.programs.hyprlock.enable {
    programs.hyprlock.settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        fail_timeout = 10;
      };

      animations.enabled = false;

      background = [
        {
          path =
            if (config.programs.hyprlock.lockImage == null) then
              "screenshot"
            else
              toString config.programs.hyprlock.lockImage;
          blur_passes = 3;
          blur_size = 3;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -400";
          monitor = lib.mkIf (
            config.programs.hyprlock.mainMonitor != null
          ) config.programs.hyprlock.mainMonitor;
          fade_on_empty = false;
          font_color = "0xffffffff";
          inner_color = "0x131313ff";
          outer_color = "0xcdc885ff";
          outline_thickness = 1;
          placeholder_text = ''Password...'';
          shadow_passes = 2;
          rounding = 8;
        }
      ];
    };
  };
}
