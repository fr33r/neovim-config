local status, indent_blankline = pcall(require, 'ibl')
if not status then
  return
end

-- https://github.com/lukas-reineke/indent-blankline.nvim
indent_blankline.setup()
