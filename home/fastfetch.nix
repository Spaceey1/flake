{
  config,
  lib,
  osConfig,
  ...
}:
let
  color = osConfig.theme;
  primary = color.palette.primary.hex;
  secondary = color.baseColors.dark-gray.hex;
in
{
  config = lib.mkIf config.programs.fastfetch.enable {
    xdg.configFile."fastfetch/config.jsonc".text = builtins.toJSON {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      "display" = {
        "size" = {
          "maxPrefix" = "MB";
          "ndigits" = 0;
        };
        "color" = primary;
      };
      "logo" = {
        "type" = "small";
        "color" = {
          "1" = primary;
          "2" = secondary;
          "3" = primary;
          "4" = secondary;
          "5" = primary;
          "6" = secondary;
        };
      };
      "modules" = [
        "title"
        {
          "type" = "custom";
          "format" = "   ";
        }
        "os"
        "wm"
        "terminal"
        "cpu"
        {
          "type" = "gpu";
          "key" = "GPU";
        }
        {
          "type" = "custom";
          "format" = " ";
        }
        {
          "type" = "custom";
          "format" = "if you read this you're gay";
        }
      ];
    };
  };

}
