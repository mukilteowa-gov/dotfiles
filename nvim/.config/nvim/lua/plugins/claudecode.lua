return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = function()
    -- Basic setup for claudecode.nvim
    -- This plugin enables the /ide command in Claude to connect to Neovim
    local ok, claudecode = pcall(require, "claudecode")
    if not ok then
      vim.notify("claudecode.nvim not loaded properly", vim.log.levels.WARN)
      return
    end

    -- Setup with minimal configuration
    claudecode.setup({
      -- Basic configuration - the plugin will handle defaults
    })

    -- Add keybindings for Claude Code functionality
    vim.keymap.set("n", "<leader>cc", function()
      vim.notify("Claude Code is active - use /ide command in Claude to connect!", vim.log.levels.INFO)
    end, { desc = "Claude Code status" })

    -- Show startup message
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.defer_fn(function()
          vim.notify("Claude Code loaded - use /ide command in Claude to connect!", vim.log.levels.INFO)
        end, 1000)
      end,
    })
  end,
}