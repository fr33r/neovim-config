
local options = vim.opt

-- line numbers.
options.relativenumber = false
options.number = true

-- indentation.
options.tabstop = 2
options.shiftwidth = 2
options.expandtab = true
options.autoindent = true

-- line wrapping.
options.wrap = false

-- search.
options.ignorecase = true
options.smartcase = true

-- cursor.
options.cursorline = false

-- appearance.
options.termguicolors = true
options.background = 'dark'
options.signcolumn = 'yes'

-- backspace.
options.backspace = 'indent,eol,start'

-- clipboard.
options.clipboard:append('unnamedplus')

-- split windows.
options.splitright = true
options.splitbelow = true

-- keywords.
options.iskeyword:append('-')
