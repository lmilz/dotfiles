local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = false
opt.termguicolors = true
opt.signcolumn = "yes"         -- immer anzeigen, kein layout-jump bei LSP
opt.cursorline = true
opt.scrolloff = 8              -- cursor bleibt nicht am rand kleben
opt.wrap = false

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true           -- case-sensitive wenn großbuchstaben genutzt
opt.hlsearch = false

-- Files
opt.undofile = true            -- persistentes undo über neustarts hinaus
opt.swapfile = false
opt.backup = false

-- Performance
opt.updatetime = 200           -- schnelleres CursorHold event (LSP hover etc.)
opt.timeoutlen = 300

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Clipboard
opt.clipboard = "unnamedplus"  -- system clipboard

-- Markdown: conceallevel + korrekte Bold/Italic-Highlights
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.api.nvim_set_hl(0, "@markup.strong",        { bold = true })
    vim.api.nvim_set_hl(0, "@markup.italic",        { italic = true })
    vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { bold = true })
    vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { italic = true })
  end,
})
