local M = {}

local default_neovide_position_animation_length = vim.g.neovide_position_animation_length
local default_neovide_cursor_animation_length = vim.g.neovide_cursor_animation_length
local default_neovide_cursor_trail_size = vim.g.neovide_cursor_trail_size
local default_neovide_cursor_animate_in_insert_mode = vim.g.neovide_cursor_animate_in_insert_mode
local default_neovide_cursor_animate_command_line = vim.g.neovide_cursor_animate_command_line
local default_neovide_scroll_animation_far_lines = vim.g.neovide_scroll_animation_far_lines
local default_neovide_scroll_animation_length = vim.g.neovide_scroll_animation_length

function M.enter()
  vim.g.neovide_position_animation_length = default_neovide_position_animation_length
  vim.g.neovide_cursor_animation_length = default_neovide_cursor_animation_length
  vim.g.neovide_cursor_trail_size = default_neovide_cursor_trail_size
  vim.g.neovide_cursor_animate_in_insert_mode = default_neovide_cursor_animate_in_insert_mode
  vim.g.neovide_cursor_animate_command_line = default_neovide_cursor_animate_command_line
  vim.g.neovide_scroll_animation_far_lines = default_neovide_scroll_animation_far_lines
  vim.g.neovide_scroll_animation_length = default_neovide_scroll_animation_length
  vim.opt.guifont = 'JetBrainsMono NFM:h17'
  vim.cmd.colorscheme 'catppuccin'
end

function M.exit()
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00
  vim.opt.guifont = 'JetBrainsMono NFM:h17'
  vim.cmd.colorscheme 'gruber-darker'
end

--- @param opts table
---@diagnostic disable-next-line: unused-local
M.setup = function(opts)
  M.exit()
end

return M
