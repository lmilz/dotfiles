return {
  -- Obsidian Vault in Neovim
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- Nur laden wenn wir im Second-Brain-Ordner sind
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Second-Brain/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Second-Brain/**.md",
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "Second-Brain",
            path = "~/Second-Brain",
          },
        },
        daily_notes = {
          folder = "Areas/Journal",
          date_format = "%Y-%m-%d",
        },
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
        -- UI Features
        ui = {
          enable = true,
          checkboxes = {
            [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
            ["x"] = { char = "", hl_group = "ObsidianDone" },
          },
        },
        follow_url_func = function(url)
          vim.fn.jobstart({ "xdg-open", url })
        end,
      })
    end,
  },

  -- Fokussiertes Schreiben
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require("zen-mode").setup({
        window = {
          width = 90,
          options = {
            signcolumn = "no",
            number = false,
            cursorline = false,
          },
        },
        plugins = {
          options = { laststatus = 0 },
          twilight = { enabled = true },
          gitsigns = { enabled = false },
        },
      })
    end,
  },

  -- Schönes Markdown Rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({
        heading = {
          enabled = true,
          sign = false,
          icons = {},       -- kein Icon-Prefix, Unterscheidung nur via Farbe + Fettschrift
        },
        code = { enabled = true },  -- Sprach-Anzeige bleibt erhalten
        bullet = {
          enabled = true,
          icons = { "•", "◦", "▸", "▹" },  -- verschiedene Symbole je Einrückungstiefe
          right_pad = 1,                     -- Abstand zwischen Symbol und Text
        },
      })
    end,
  },
}
