return {
  "linux-cultist/venv-selector.nvim",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts, {
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
      parents = 0,
    })
  end,
}
