{ config, pkgs, ... }:

{
	programs.neovim = {
		enable = true;
		defaultEditor = true;

		vimAlias = true;
		viAlias = true;

# Plugins formerly managed by vim-plug
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
		];

		extraLuaConfig = builtins.readFile ./nvim/init-extra.lua;
			
	};
	home.file.".config/nvim/colors/custom.vim".source =
		./nvim/custom.vim;
}
