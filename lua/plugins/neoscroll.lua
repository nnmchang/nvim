return {
  "karb94/neoscroll.nvim",
  config = function()
    require("neoscroll").setup {}

    local t = {}
    -- Syntax: t[keys] = {function, {function arguments}}
    t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "false", "100" } }
    t["<C-d>"] = { "scroll", { "vim.wo.scroll", "false", "100" } }
    t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "false", "180" } }
    t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "false", "180" } }
    t["<C-y>"] = { "scroll", { "-0.10", "false", "40" } }
    t["<C-e>"] = { "scroll", { "0.10", "false", "40" } }
    t["zt"] = { "zt", { "100" } }
    t["zz"] = { "zz", { "100" } }
    t["zb"] = { "zb", { "100" } }

    require("neoscroll.config").set_mappings(t)
  end,
}
