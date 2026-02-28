-- Passt gut zu deinem Alacritty dark theme
return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000, -- zuerst laden
    config = function()
      require("kanagawa").setup({
        background = { dark = "dragon" },
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
