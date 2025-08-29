return {
  "ojroques/nvim-osc52",
  config = function()
    require("osc52").setup({
      max_length = 0,      -- Maximum length of selection (0 for no limit)
      silent = false,      -- Disable message on successful copy
      trim = false,        -- Trim surrounding whitespaces before copy
    })

    -- Set clipboard to use OSC 52
    local function copy(lines, _)
      require('osc52').copy(table.concat(lines, '\n'))
    end

    local function paste()
      return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
    end

    vim.g.clipboard = {
      name = 'osc52',
      copy = {['+'] = copy, ['*'] = copy},
      paste = {['+'] = paste, ['*'] = paste},
    }

    -- Key mappings for easy clipboard operations
    vim.keymap.set("n", "<leader>c", '"+y', { desc = "Copy to system clipboard" })
    vim.keymap.set("v", "<leader>c", '"+y', { desc = "Copy to system clipboard" })
    vim.keymap.set("n", "<leader>v", '"+p', { desc = "Paste from system clipboard" })
    vim.keymap.set("v", "<leader>v", '"+p', { desc = "Paste from system clipboard" })
    
    -- Auto-copy visual selections to clipboard (optional)
    -- Uncomment the line below if you want automatic copying of visual selections
    -- vim.api.nvim_create_autocmd("TextYankPost", {
    --   callback = function()
    --     if vim.v.event.operator == "y" and vim.v.event.regname == "" then
    --       require("osc52").copy_register("+")
    --     end
    --   end,
    -- })
  end,
}