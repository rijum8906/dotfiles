-- ~/.config/nvim/lua/plugins/tokyonight.lua
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "storm", -- storm | night | moon | day
    transparent = true,
    terminal_colors = true,

    styles = {
      comments = { italic = true },
      keywords = { italic = false },
      sidebars = "transparent",
      floats = "transparent",
    },

    sidebars = {
      "qf",
      "help",
      "terminal",
      "packer",
      "neo-tree",
    },

    on_colors = function(colors)
      -- optional: fine-tune contrast
      colors.bg = "NONE"
      colors.bg_dark = "NONE"
      colors.bg_float = "NONE"
      colors.bg_sidebar = "NONE"
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
