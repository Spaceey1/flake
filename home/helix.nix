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
              bg = colors.baseColors.dark-gray.hex;
              fg = colors.baseColors.white.hex;
            };
            # lsp suggestions
            "ui.menu.selected" = {
              bg = colors.baseColors.green.hex;
              fg = colors.baseColors.black.hex;
            };
            "ui.linenr" = {
              fg = "none";
              bg = "none";
            };
            "ui.popup" = {
              bg = colors.baseColors.black.hex;
            };
            "ui.linenr.selected" = {
              fg = colors.baseColors.white.hex;
              bg = "none";
              modifiers = [ "bold" ];
            };
            "ui.selection" = {
              bg = colors.baseColors.dark-gray.hex;
            };
            "ui.selection.primary" = {
              bg = colors.baseColors.gray.hex;
            };
            "comment" = {
              fg = colors.baseColors.gray.hex;
            };
            "ui.statusline" = {
              fg = colors.baseColors.white.hex;
              bg = colors.baseColors.dark-gray.hex;
            };
            "ui.statusline.inactive" = {
              fg = colors.baseColors.white.hex;
              bg = colors.baseColors.dark-gray.hex;
            };
            "ui.help" = {
              fg = colors.baseColors.white.hex;
              bg = colors.baseColors.dark-gray.hex;
            };
            "ui.cursor" = {
              modifiers = [ "reversed" ];
            };
            "variable" = colors.baseColors.white.hex;
            "variable.builtin" = colors.baseColors.magenta.hex;
            "constant.numeric" = colors.baseColors.green.hex;
            "constant" = colors.baseColors.green.hex;
            "attributes" = colors.baseColors.yellow.hex;
            "type" = colors.baseColors.green.hex;
            "ui.cursor.match" = {
              fg = colors.baseColors.blue.hex;
              modifiers = [ "underlined" ];
            };
            "string" = colors.baseColors.red.hex;
            "variable.other.member" = colors.baseColors.cyan.hex;
            "constant.character.escape" = colors.baseColors.orange.hex;
            "function" = colors.baseColors.yellow.hex;
            "variable.function" = colors.baseColors.yellow.hex;
            "constructor" = colors.baseColors.yellow.hex;
            "special" = colors.baseColors.blue.hex;
            "keyword" = colors.baseColors.magenta.hex;
            "label" = colors.baseColors.magenta.hex;
            "namespace" = colors.baseColors.white.hex;
            "diff.plus" = colors.baseColors.green.hex;
            "diff.delta" = colors.baseColors.yellow.hex;
            "diff.minus" = colors.baseColors.red.hex;
            "diagnostic" = {
              modifiers = [ "underlined" ];
            };
            "ui.gutter" = {
              bg = "none";
            };
            "info" = colors.baseColors.blue.hex;
            "hint" = colors.baseColors.dark-gray.hex;
            "debug" = colors.baseColors.dark-gray.hex;
            "warning" = colors.baseColors.yellow.hex;
            "error" = colors.baseColors.red.hex;
            "ui.virtual.inlay-hint" = colors.baseColors.gray.hex;
          };
      };
    };
    home.packages = [
      pkgs.lldb
      pkgs.nil
    ];
  };
}
