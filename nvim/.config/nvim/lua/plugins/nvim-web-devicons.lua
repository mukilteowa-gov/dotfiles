return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      -- globally enable different highlight colors per icon (default to true)
      -- if set to false all icons will have the default icon's color
      color_icons = true,
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = true,
      -- globally enable "strict" selection of icons - icon will be looked up in
      -- different tables, first by filename, and if not found by extension; this
      -- prevents cases when file doesn't have any extension but still gets some icon
      -- because its name happened to match some extension (default to false)
      strict = true,
      -- same as `override` but specifically for overrides by filename
      -- takes effect when `strict` is true
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore"
        },
        ["README.md"] = {
          icon = "",
          color = "#519aba",
          name = "Readme"
        },
        ["Makefile"] = {
          icon = "",
          color = "#427819",
          name = "Makefile"
        },
        ["Dockerfile"] = {
          icon = "",
          color = "#458ee6",
          name = "Dockerfile"
        },
        [".env"] = {
          icon = "",
          color = "#faf743",
          name = "Env"
        },
      },
      -- same as `override` but specifically for overrides by extension
      -- takes effect when `strict` is true
      override_by_extension = {
        ["log"] = {
          icon = "",
          color = "#81e043",
          name = "Log"
        },
        ["conf"] = {
          icon = "",
          color = "#6d8086",
          name = "Conf"
        },
        ["toml"] = {
          icon = "",
          color = "#6d8086",
          name = "Toml"
        },
        ["yaml"] = {
          icon = "",
          color = "#6d8086",
          name = "Yaml"
        },
        ["yml"] = {
          icon = "",
          color = "#6d8086",
          name = "Yml"
        },
      },
    })
  end,
}