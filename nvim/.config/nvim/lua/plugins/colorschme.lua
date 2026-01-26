return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "storm", -- or "night", "moon", "day"
    transparent = true, -- Enables a transparent background
    styles = {
      sidebars = "transparent", -- Makes sidebars (like nvim-tree, qf, terminal) transparent
      floats = "transparent", -- Makes floating windows transparent (like completion menus)
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    -- Optional: Ensure the colorscheme is loaded immediately
    vim.cmd.colorscheme("tokyonight")
  end,
}
