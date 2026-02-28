return {
  -- Mason: automatische LSP-Installation
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",        -- C/C++
          "rust_analyzer", -- Rust
          "lua_ls",        -- Lua (für nvim config selbst)
          "pyright",       -- Python
          "gopls",         -- Go
        },
      })
    end,
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Neue API (Neovim 0.11+): vim.lsp.config statt require('lspconfig').xxx.setup()
      vim.lsp.config("clangd",        { capabilities = capabilities })
      vim.lsp.config("rust_analyzer", { capabilities = capabilities })
      vim.lsp.config("pyright",       { capabilities = capabilities })
      vim.lsp.config("gopls",         { capabilities = capabilities })
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })
      vim.lsp.enable({ "clangd", "rust_analyzer", "lua_ls", "pyright", "gopls" })

      -- Keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "Go to Definition")
          map("gr", require("telescope.builtin").lsp_references, "References")
          map("K", vim.lsp.buf.hover, "Hover Docs")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>cf", vim.lsp.buf.format, "Format")
        end,
      })
    end,
  },

  -- Formatter (prettier, black, rustfmt, clang-format, gofmt)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd   = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua    = { "stylua" },
          python = { "black" },
          rust   = { "rustfmt" },
          c      = { "clang_format" },
          cpp    = { "clang_format" },
          go     = { "gofmt" },
        },
        format_on_save = {
          timeout_ms   = 500,
          lsp_fallback = true,
        },
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
