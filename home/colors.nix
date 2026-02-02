let
  # --- CONVERSION LOGIC ---
  
  hexChars = "0123456789abcdef";
  
  # Hex to Int helper
  hexDigitToInt = c: 
    let
      # Mapping characters to their decimal values
      map = {
        "0"=0; "1"=1; "2"=2; "3"=3; "4"=4; "5"=5; "6"=6; "7"=7; "8"=8; "9"=9;
        "a"=10; "b"=11; "c"=12; "d"=13; "e"=14; "f"=15;
        "A"=10; "B"=11; "C"=12; "D"=13; "E"=14; "F"=15;
      };
    in map."${c}";

  # Convert 2-char hex string to 0-255 int
  hexPairToInt = s: (hexDigitToInt (builtins.substring 0 1 s)) * 16 
                   + (hexDigitToInt (builtins.substring 1 1 s));

  # Convert int to 2-char hex string
  intToHex = i:
    let
      low = i % 16;
      high = (i / 16) % 16;
    in "${builtins.substring high 1 hexChars}${builtins.substring low 1 hexChars}";

  # --- API FUNCTIONS ---

  # Takes "#ffffff", returns { r=255; g=255; b=255; }
  hexToRgb = hex: 
    let 
      cleanHex = builtins.replaceStrings ["#"] [""] hex;
    in {
      r = hexPairToInt (builtins.substring 0 2 cleanHex);
      g = hexPairToInt (builtins.substring 2 2 cleanHex);
      b = hexPairToInt (builtins.substring 4 2 cleanHex);
    };

  rgbToHex = { r, g, b }: "#" + (intToHex r) + (intToHex g) + (intToHex b);

  rawPalette = {
    gray      = "#665c54";
    dark-gray = "#3c3836";
    white     = "#ffffff";
    black     = "#020202";
    red       = "#f0318f";
    green     = "#41d95a";
    yellow    = "#ffff4d";
    orange    = "#e49342";
    blue      = "#4d97ff";
    magenta   = "#a64dff";
    cyan      = "#d9f86e";
  };

in
builtins.mapAttrs (name: value: {
  hex = value;
  rgb = hexToRgb value;
  # Convenience string for CSS or similar: "rgb(255, 255, 255)"
  rgbStr = let c = hexToRgb value; in "rgb(${toString c.r}, ${toString c.g}, ${toString c.b})";
}) rawPalette
