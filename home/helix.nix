{ pkgs, ... }:

{
  config = {
    programs.helix = {
      enable = true;
      package = pkgs.evil-helix;
      settings = {
        theme = "thweme";
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
          auto-format = true;
          trim-final-newlines = true;
          completion-replace = true;
          completion-trigger-len = 1;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          completion-timeout = 5;
          lsp.display-inlay-hints = true;
        };
        keys = {
          insert = {
            #tab = "completion";
            #ret = "completion";
          };
          normal = {
            "=" = ":format";
            F2 = "rename_symbol";
          };
        };
      };
      themes = {
        thweme =
          let
            transparent = "none";
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
          in
          {
            "ui.menu" = {
              bg = dark-gray;
              fg = white;
            };
            # lsp suggestions
            "ui.menu.selected" = {
              bg = green;
              fg = black;
            };
            "ui.linenr" = {
              fg = transparent;
              bg = transparent;
            };
            "ui.popup" = {
              bg = black;
            };
            "ui.linenr.selected" = {
              fg = white;
              bg = transparent;
              modifiers = [ "bold" ];
            };
            "ui.selection" = {
              bg = dark-gray;
            };
            "ui.selection.primary" = {
              bg = gray;
            };
            "comment" = {
              fg = gray;
            };
            "ui.statusline" = {
              fg = white;
              bg = dark-gray;
            };
            "ui.statusline.inactive" = {
              fg = white;
              bg = dark-gray;
            };
            "ui.help" = {
              fg = white;
              bg = dark-gray;
            };
            "ui.cursor" = {
              modifiers = [ "reversed" ];
            };
            "variable" = white;
            "variable.builtin" = magenta;
            "constant.numeric" = green;
            "constant" = green;
            "attributes" = yellow;
            "type" = green;
            "ui.cursor.match" = {
              fg = blue;
              modifiers = [ "underlined" ];
            };
            "string" = red;
            "variable.other.member" = cyan;
            "constant.character.escape" = orange;
            "function" = yellow;
            "variable.function" = yellow;
            "constructor" = yellow;
            "special" = blue;
            "keyword" = magenta;
            "label" = magenta;
            "namespace" = white;
            "diff.plus" = green;
            "diff.delta" = yellow;
            "diff.minus" = red;
            "diagnostic" = {
              modifiers = [ "underlined" ];
            };
            "ui.gutter" = {
              bg = transparent;
            };
            "info" = blue;
            "hint" = dark-gray;
            "debug" = dark-gray;
            "warning" = yellow;
            "error" = red;
            "ui.virtual.inlay-hint" = gray;
          };
      };
    };
    home.packages = [
      pkgs.lldb
      pkgs.nil
    ];
  };
}
