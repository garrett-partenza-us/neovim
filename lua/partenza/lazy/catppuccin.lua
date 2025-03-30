return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- Set the colorscheme to catppuccin-mocha (default)
      vim.cmd.colorscheme("catppuccin-macchiato")
      
      -- If you want to use a specific flavor, uncomment one of the following:
      -- vim.g.catppuccin_flavour = "latte"       -- For catppuccin-latte
      -- vim.g.catppuccin_flavour = "frappe"      -- For catppuccin-frappe
      -- vim.g.catppuccin_flavour = "macchiato"   -- For catppuccin-macchiato
      -- vim.g.catppuccin_flavour = "mocha"       -- For catppuccin-mocha (default)
    end
  }
}
