return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local mason_dap = require("mason-nvim-dap")

    -- 1. Setup Mason and Mason-DAP
    require("mason").setup()
    mason_dap.setup({
      -- This ensures that whatever you install via Mason is 
      -- automatically ready to use without naming it here.
      automatic_installation = true,
      -- The Universal Handler: This is the "infinite" part.
      -- It automatically configures ANY adapter you install.
      handlers = {
        function(config)
          mason_dap.default_setup(config)
        end,
      },
    })

    -- 2. Setup UI & Auto-Open/Close
    dapui.setup()
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- 3. Load VS Code launch.json configurations if present
    -- This makes it "auto-work" for specific project needs
    require('dap.ext.vscode').load_launchjs()

    -- 4. Keybindings (The "IDE" feel)
    local keymap = vim.keymap.set
    keymap('n', '<F5>', dap.continue, { desc = "Debug: Start/Continue" })
    keymap('n', '<F10>', dap.step_over, { desc = "Debug: Step Over" })
    keymap('n', '<F11>', dap.step_into, { desc = "Debug: Step Into" })
    keymap('n', '<F12>', dap.step_out, { desc = "Debug: Step Out" })
    keymap('n', '<leader>b', dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    keymap('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = "Debug: Set Breakpoint" })
  end,
}
