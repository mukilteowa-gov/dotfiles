return {
  "christoomey/vim-tmux-navigator",
  config = function()
    -- Disable tmux navigator when zooming the Vim pane
    vim.g.tmux_navigator_disable_when_zoomed = 1
    
    -- Save on switch - automatically save the current buffer when switching panes
    vim.g.tmux_navigator_save_on_switch = 2
    
    -- Preserve zoom when switching panes
    vim.g.tmux_navigator_preserve_zoom = 1

    -- Custom keybindings (these are the defaults, but made explicit)
    vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', { silent = true, desc = "Navigate left" })
    vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', { silent = true, desc = "Navigate down" })
    vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', { silent = true, desc = "Navigate up" })
    vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', { silent = true, desc = "Navigate right" })
    vim.keymap.set('n', '<C-\\>', ':TmuxNavigatePrevious<CR>', { silent = true, desc = "Navigate to previous pane" })
  end,
}