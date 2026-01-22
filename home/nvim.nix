{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    vimAlias = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      nvim-cmp
      cmp-nvim-lsp
      vim-suda
      nvim-parinfer
      yuck-vim
      plenary-nvim
      telescope-nvim
      nvim-dap
      nvim-dap-ui
    ];
    extraLuaConfig = ''
      		vim.opt.undodir = "${config.home.homeDirectory}" .. "/.vim/undodir"
      		vim.opt.undofile = true
      		''
    + builtins.readFile ./nvim/init-extra.lua;

  };
  home.file.".config/nvim/colors/custom.vim".source = ./nvim/custom.vim;

}
