return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      treesitter = {
        ensure_installed = { "htmldjango" },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "djlint" } },
  },
}
