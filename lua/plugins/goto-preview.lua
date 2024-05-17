return {
  "rmagatti/goto-preview",
  config = function() require("goto-preview").setup {} end,
  keys = {
    { "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>" },
    { "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>" },
  },
}
