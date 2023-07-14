local dap = require('dap')
local dapui = require('dapui')
local daptext = require('nvim-dap-virtual-text')
local telescope = require('telescope')

dap.adapters.cpp = {
  type = 'executable',
  command = 'D:\\Programs\\LLVM\\bin\\lldb-vscode',
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}

require('dap').set_log_level('DEBUG')

vim.fn.sign_define(
    "DapBreakpoint",
    { text = "●", texthl = "", linehl = "debugBreakpoint", numhl = "debugBreakpoint" }
)
vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = "◆", texthl = "", linehl = "debugBreakpoint", numhl = "debugBreakpoint" }
)
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "debugPC", numhl = "debugPC" })
dap.defaults.fallback.force_external_terminal = true
daptext.setup()
dapui.setup({
    layouts = {
        {
            elements = {
                "watches",
                { id = "scopes", size = 0.5 },
                { id = "repl", size = 0.15 },
            },
            size = 79,
            position = "left",
        },
        {
            elements = {
                "console",
            },
            size = 0.25,
            position = "bottom",
        },
    },
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
        },
    },
})
telescope.load_extension("dap")


local Remap = require('debugger_map')
local nnoremap = Remap.nnoremap

-- Start
nnoremap("<F9>", function()
    dap.continue()
    dapui.open()
end)
-- Exit
nnoremap("<F7>", function()
    dap.terminate()
    dapui.close()
    vim.cmd("sleep 50ms")
    dap.repl.close()
end)
-- Restart
nnoremap("<F21>", function()
    dap.terminate()
    vim.cmd("sleep 50ms")
    dap.repl.close()
    dap.continue()
end) -- Shift F9
nnoremap("<leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
nnoremap("<F8>", function()
    dap.toggle_breakpoint()
end)
nnoremap("<F20>", function()
    dap.clear_breakpoints()
end) -- SHIFT+F8
nnoremap("<F10>", function()
    dap.step_over()
end)
nnoremap("<leader>rc", function()
    dap.run_to_cursor()
end)
nnoremap("<F11>", function()
    dap.step_into()
end)
nnoremap("<F12>", function()
    dap.step_out()
end)
nnoremap("<leader>dp", function()
    dap.pause()
end)
nnoremap("<leader>dtc", function()
    telescope.extensions.dap.commands({})
end)
-- DEBUGGER
--vim.keymap.set('n', '<F9>', ':lua require"dap".continue()<CR>', {silent = true})
-- vim.keymap.set('n', '<F10>', ':lua require"dap".step_over()<CR>', {silent = true})
-- vim.keymap.set('n', '<F11>', ':lua require"dap".step_into()<CR>', {silent = true})
-- vim.keymap.set('n', '<F12>', ':lua require"dap".step_out()<CR>', {silent = true})
-- vim.keymap.set('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>', {silent = true})
-- vim.keymap.set('n', '<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', {silent = true})
-- vim.keymap.set('n', '<leader>lp', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', {silent = true})
-- vim.keymap.set('n', '<leader>dr', ':lua require"dap".repl.open()<CR>', {silent = true})
-- vim.keymap.set('n', '<leader>dl', ':lua require"dap".run_last()<CR>', {silent = true})
