-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

local keymap = vim.keymap
keymap.set({ "n", "x" }, "x", '"_x')
keymap.set({ "n", "x" }, "X", '"_X')
keymap.set({ "n", "x" }, "d", '"_d')
keymap.set({ "n", "x" }, "D", '"_D')

local neoscroll = require "neoscroll"
local nskeymap = {
  ["<C-u>"] = function() neoscroll.ctrl_u { duration = 100 } end,
  ["<C-d>"] = function() neoscroll.ctrl_d { duration = 100 } end,
  ["<C-b>"] = function() neoscroll.ctrl_b { duration = 180 } end,
  ["<C-f>"] = function() neoscroll.ctrl_f { duration = 180 } end,
  ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 40 }) end,
  ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor = false, duration = 40 }) end,
  ["zt"] = function() neoscroll.zt { half_win_duration = 100 } end,
  ["zz"] = function() neoscroll.zz { half_win_duration = 100 } end,
  ["zb"] = function() neoscroll.zb { half_win_duration = 100 } end,
}
for key, func in pairs(nskeymap) do
  keymap.set({ "n", "v", "x" }, key, func)
end
