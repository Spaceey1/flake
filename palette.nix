let
  rawPalette = {
    gray = "#665c54";
    dark-gray = "#3c3836";
    white = "#ffffff";
    black = "#020202";
    red = "#f0318f";
    green = "#41d95a";
    yellow = "#ffff4d";
    orange = "#e49342";
    blue = "#4d97ff";
    magenta = "#a64dff";
    cyan = "#d9f86e";
  };
in
{
  inherit rawPalette;
  palette = {
    primary = rawPalette.magenta;
    background = rawPalette.black;
    text = rawPalette.white;
  };
}
