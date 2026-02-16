let
  hexDigitToInt =
    c:
    let
      map = {
        "0" = 0;
        "1" = 1;
        "2" = 2;
        "3" = 3;
        "4" = 4;
        "5" = 5;
        "6" = 6;
        "7" = 7;
        "8" = 8;
        "9" = 9;
        "a" = 10;
        "b" = 11;
        "c" = 12;
        "d" = 13;
        "e" = 14;
        "f" = 15;
        "A" = 10;
        "B" = 11;
        "C" = 12;
        "D" = 13;
        "E" = 14;
        "F" = 15;
      };
    in
    map."${c}";

  hexPairToInt =
    s:
    ((hexDigitToInt (builtins.substring 0 1 s)) * 16 + (hexDigitToInt (builtins.substring 1 1 s)))
    / 255.0;

  hexToRgb =
    hex:
    let
      cleanHex = builtins.replaceStrings [ "#" ] [ "" ] hex;
    in
    {
      r = hexPairToInt (builtins.substring 0 2 cleanHex);
      g = hexPairToInt (builtins.substring 2 2 cleanHex);
      b = hexPairToInt (builtins.substring 4 2 cleanHex);
    };
  rawPalette = import ./palette.nix;
in
{
  baseColors = builtins.mapAttrs (
    name: value:
    let
      rgb = hexToRgb value;
    in
    {
      hex = value;
      inherit rgb;
      rgbStr = "rgb(${toString rgb.r}, ${toString rgb.g}, ${toString rgb.b})";
      rgbRaw = "${toString rgb.r},${toString rgb.g},${toString rgb.b}";
    }
  ) rawPalette.rawPalette;

  palette = builtins.mapAttrs (
    name: value:
    let
      rgb = hexToRgb value;
    in
    {
      hex = value;
      inherit rgb;
      rgbStr = "rgb(${toString rgb.r}, ${toString rgb.g}, ${toString rgb.b})";
      rgbRaw = "${toString rgb.r},${toString rgb.g},${toString rgb.b}";
    }
  ) rawPalette.palette;
}
