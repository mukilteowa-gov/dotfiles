return {
  "github/copilot.vim",
  config = function()
    -- Enable Copilot for specific filetypes
    vim.g.copilot_filetypes = {
      ["*"] = false,
      ["javascript"] = true,
      ["typescript"] = true,
      ["lua"] = true,
      ["rust"] = true,
      ["c"] = true,
      ["c++"] = true,
      ["go"] = true,
      ["python"] = true,
      ["java"] = true,
      ["html"] = true,
      ["css"] = true,
      ["scss"] = true,
      ["json"] = true,
      ["yaml"] = true,
      ["markdown"] = true,
      ["sh"] = true,
      ["bash"] = true,
      ["zsh"] = true,
      ["vim"] = true,
    }

    -- Copilot keybindings
    vim.keymap.set('i', '<C-g>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
      desc = "Accept copilot suggestion"
    })
    
    -- Disable default Tab mapping (we'll use C-g instead)
    vim.g.copilot_no_tab_map = true
    
    -- Additional keybindings for copilot navigation (using leader to avoid conflicts with tmux navigator)
    vim.keymap.set('i', '<leader>L', '<Plug>(copilot-accept-word)', { desc = "Accept copilot word" })
    vim.keymap.set('i', '<leader>J', '<Plug>(copilot-next)', { desc = "Next copilot suggestion" })
    vim.keymap.set('i', '<leader>K', '<Plug>(copilot-previous)', { desc = "Previous copilot suggestion" })
    vim.keymap.set('i', '<leader>H', '<Plug>(copilot-dismiss)', { desc = "Dismiss copilot suggestion" })
    
    -- Node.js version (if you have multiple versions)
    -- vim.g.copilot_node_command = "/path/to/node"
  end,
}