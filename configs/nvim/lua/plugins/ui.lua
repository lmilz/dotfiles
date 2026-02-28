return {
  -- Startseite
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                        ",
        "   ██╗     ███╗   ███╗██╗██╗     ███████╗",
        "   ██║     ████╗ ████║██║██║     ╚════██║",
        "   ██║     ██╔████╔██║██║██║         ██╔╝",
        "   ██║     ██║╚██╔╝██║██║██║        ██╔╝ ",
        "   ███████╗██║ ╚═╝ ██║██║███████╗   ██║  ",
        "   ╚══════╝╚═╝     ╚═╝╚═╝╚══════╝   ╚═╝  ",
        "                                        ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("n", "  Neue Datei",       "<cmd>ene<cr>"),
        dashboard.button("f", "  Dateien suchen",   "<cmd>Telescope find_files<cr>"),
        dashboard.button("r", "  Zuletzt geöffnet", "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("j", "  Journal",          "<cmd>Telescope find_files cwd=~/Second-Brain/Areas/Journal<cr>"),
        dashboard.button("z", "  Zettelkasten",     "<cmd>Telescope find_files cwd=~/Second-Brain/Areas/Zettelkasten<cr>"),
        dashboard.button("g", "  LazyGit",          "<cmd>LazyGit<cr>"),
        dashboard.button("q", "  Beenden",          "<cmd>qa<cr>"),
      }

      require("alpha").setup(dashboard.config)
    end,
  },

  -- Tabs für offene Dateien
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          separator_style = "slant",
          show_buffer_close_icons = true,
          show_close_icon = false,
          custom_filter = function(buf)
            return vim.bo[buf].filetype ~= "alpha"
          end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "Files",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })
    end,
  },

  -- LazyGit Integration
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitCurrentFile" },
  },

  -- Linke Sidebar (Dateibaum)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    init = function()
      -- Neo-tree nur öffnen wenn Neovim mit einer Datei gestartet wird (nicht bei alpha)
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() > 0 then
            require("neo-tree.command").execute({ action = "show", position = "left" })
            vim.cmd("wincmd p")
          end
        end,
      })
    end,
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          position = "left",
          width = 35,
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = { enabled = true },
        },
      })
    end,
  },

  -- Git-Zeichen in der Signalspalte
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "│" },
          change       = { text = "│" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(buf)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
          end
          local gs = require("gitsigns")
          map("]g", gs.next_hunk,          "Next Git Hunk")
          map("[g", gs.prev_hunk,          "Prev Git Hunk")
          map("<leader>gs", gs.stage_hunk,  "Stage Hunk")
          map("<leader>gr", gs.reset_hunk,  "Reset Hunk")
          map("<leader>gp", gs.preview_hunk, "Preview Hunk")
          map("<leader>gb", gs.blame_line,  "Blame Line")
        end,
      })
    end,
  },

  -- Keymap-Übersicht
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        delay = 400,
      })
      -- Gruppen-Labels für leader-Präfixe
      require("which-key").add({
        { "<leader>b",  group = "Buffer" },
        { "<leader>c",  group = "Code" },
        { "<leader>f",  group = "Find" },
        { "<leader>g",  group = "Git" },
        { "<leader>n",  group = "Notes" },
        { "<leader>fn", desc = "Find Notes (all)" },
        { "<leader>fj", desc = "Find Journal" },
        { "<leader>fz", desc = "Find Zettelkasten" },
        { "<leader>fl", desc = "Find Blog" },
        { "<leader>fw", desc = "Find Website" },
        { "<leader>ft", desc = "Find TODOs" },
        { "<leader>gg", desc = "LazyGit" },
        { "<leader>nz", desc = "Zen Mode" },
      })
    end,
  },
}
