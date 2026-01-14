{ pkgs, ... }:

{
  config = {
    programs.helix = {
      enable = true;
      package = pkgs.evil-helix;
      settings = {
        theme = "onedarker";
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
    };
    home.packages = [ pkgs.lldb ];
  };
}
