-------------------------------------------------
-- 1. Options
-------------------------------------------------
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = "%s%=%l│"

vim.cmd.colorscheme("custom")

-------------------------------------------------
-- 2. Keymaps
-------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<A-j>", "10j", opts)
map("n", "<A-k>", "10k", opts)

map("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
map("n", "<C-d>", "<cmd>Telescope<CR>", opts)
map("n", "<C-x>", "ggvG=", opts)

map("n", "K", function ()
	for _, d in ipairs(vim.diagnostic.get(0)) do
		print(d.message)
	end
end, opts)

-------------------------------------------------
-- 3. Globals
-------------------------------------------------
vim.g.copilot_enabled = 0

-------------------------------------------------
-- 4. Commands
-------------------------------------------------
vim.api.nvim_create_user_command("W", function()
	vim.cmd("w suda://%")
end, {})

vim.api.nvim_create_user_command("Wq", function()
	vim.cmd("wq suda://%")
end, {})

-------------------------------------------------
-- 5. LSP / cmp / mason
-------------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup()

local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Down>"] = cmp.mapping.select_next_item(),
		["<Up>"] = cmp.mapping.select_prev_item(),
	},
	sources = {
		{ name = "nvim_lsp" },
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
require("mason-lspconfig").setup()
vim.diagnostic.config({
	virtual_text = true,
})
