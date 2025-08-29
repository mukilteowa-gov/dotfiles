return {
  "sidebar-nvim/sidebar.nvim",
  config = function()
    require("sidebar-nvim").setup({
      disable_default_keybindings = 0,
      bindings = nil,
      open = false,
      side = "left",
      initial_width = 35,
      hide_statusline = false,
      update_interval = 1000,
      sections = { "datetime", "git", "diagnostics" },
      section_separator = "-----",
      section_title = true,
      containers = {
        attach_shell = "/bin/sh",
        show_all = true,
        interval = 5000,
      },
      datetime = {
        format = "%a %b %d, %H:%M",
        clocks = { { name = "local" } }
      },
      todos = {
        ignored_paths = { "~/.cargo/*" },
        initially_closed = false,
      },
      disable_closing_prompt = false
    })

    -- Keybindings for info sidebar (avoiding conflict with nvim-tree's <leader>e)
    vim.keymap.set("n", "<leader>si", function()
      require("sidebar-nvim").toggle()
    end, { desc = "Toggle info sidebar" })

    vim.keymap.set("n", "<leader>sb", function()
      require("sidebar-nvim").open()
    end, { desc = "Open info sidebar" })
    
    vim.keymap.set("n", "<leader>sc", function()
      require("sidebar-nvim").close()
    end, { desc = "Close info sidebar" })
  end,
}