local status, _ = pcall(vim.cmd, 'colorscheme poimandres') 
if not status then
  print('colorscheme not found!')
end
