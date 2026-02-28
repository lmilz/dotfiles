return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter    = true,
          telescope     = { enabled = true },
          which_key     = true,
          gitsigns      = true,
          indent_blankline = { enabled = true },
          mason         = true,
          bufferline    = true,
          native_lsp    = {
            enabled = true,
            underlines = {
              errors      = { "underline" },
              hints       = { "underline" },
              warnings    = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
