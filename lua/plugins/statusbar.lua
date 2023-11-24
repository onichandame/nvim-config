local function cpu_usage()
  return string.gsub(vim.fn.system("top -bn1 | grep 'Cpu(s)' | awk '{print $2}'"), '\n', '')
end

local function mem_usage()
  local raw = string.gsub(vim.fn.system("free | grep Mem | awk '{print $3/$2 * 100.0}'"), '\n', '')
  return string.format("%.2f", tonumber(raw))
end

require('lualine').setup({
  options = { theme = require('lualine.themes.solarized_dark') },
  sections = {
    lualine_c = { 'lsp_progress' },
    lualine_x = { 'filename', 'encoding', 'filetype' },
    lualine_y = { function()
      return 'cpu: ' .. cpu_usage() .. '%%'
    end, function()
      return 'mem: ' .. mem_usage() .. '%%'
    end },
    lualine_z = { 'progress', 'location', },
  }
}) --- status line
