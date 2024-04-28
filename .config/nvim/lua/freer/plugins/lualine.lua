local status, lualine = pcall(require, 'lualine')
if not status then
  return
end

-- 34:00 for customizing colors.

lualine.setup({
  theme = 'vscode',
})
