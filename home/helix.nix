{ pkgs, ... }:

let
  colors = import ./colors.nix;
  in
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
          completion-replace = false;
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
          {
            "ui.menu" = {
              bg = colors.dark-gray.hex;
              fg = colors.white.hex;
            };
            # lsp suggestions
            "ui.menu.selected" = {
              bg = colors.green.hex;
              fg = colors.black.hex;
            };
            "ui.linenr" = {
              fg = "none";
              bg = "none";
            };
            "ui.popup" = {
              bg = colors.black.hex;
            };
            "ui.linenr.selected" = {
              fg = colors.white.hex;
              bg = "none";
              modifiers = [ "bold" ];
            };
            "ui.selection" = {
              bg = colors.dark-gray.hex;
            };
            "ui.selection.primary" = {
              bg = colors.gray.hex;
            };
            "comment" = {
              fg = colors.gray.hex;
            };
            "ui.statusline" = {
              fg = colors.white.hex;
              bg = colors.dark-gray.hex;
            };
            "ui.statusline.inactive" = {
              fg = colors.white.hex;
              bg = colors.dark-gray.hex;
            };
            "ui.help" = {
              fg = colors.white.hex;
              bg = colors.dark-gray.hex;
            };
            "ui.cursor" = {
              modifiers = [ "reversed" ];
            };
            "variable" = colors.white.hex;
            "variable.builtin" = colors.magenta.hex;
            "constant.numeric" = colors.green.hex;
            "constant" = colors.green.hex;
            "attributes" = colors.yellow.hex;
            "type" = colors.green.hex;
            "ui.cursor.match" = {
              fg = colors.blue.hex;
              modifiers = [ "underlined" ];
            };
            "string" = colors.red.hex;
            "variable.other.member" = colors.cyan.hex;
            "constant.character.escape" = colors.orange.hex;
            "function" = colors.yellow.hex;
            "variable.function" = colors.yellow.hex;
            "constructor" = colors.yellow.hex;
            "special" = colors.blue.hex;
            "keyword" = colors.magenta.hex;
            "label" = colors.magenta.hex;
            "namespace" = colors.white.hex;
            "diff.plus" = colors.green.hex;
            "diff.delta" = colors.yellow.hex;
            "diff.minus" = colors.red.hex;
            "diagnostic" = {
              modifiers = [ "underlined" ];
            };
            "ui.gutter" = {
              bg = "none";
            };
            "info" = colors.blue.hex;
            "hint" = colors.dark-gray.hex;
            "debug" = colors.dark-gray.hex;
            "warning" = colors.yellow.hex;
            "error" = colors.red.hex;
            "ui.virtual.inlay-hint" = colors.gray.hex;
          };
      };
    };
    home.packages = [
      pkgs.lldb
      pkgs.nil
    ];
  };
}
