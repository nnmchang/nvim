if true then return {} end
local helper = {}

-- keymap
-- ref: https://github.com/skanehira/dotfiles/blob/master/vim/init.lua
for _, mode in pairs { "n", "v", "i", "s", "o", "c", "t", "x" } do
  helper[mode .. "map"] = function(lhs, rhs, opts) vim.keymap.set(mode, lhs, rhs, opts or { silent = true }) end
end
return {
  -- SKK
  {
    "vim-skk/skkeleton",
    lazy = false,
    dependencies = { "vim-denops/denops.vim" },
    init = function()
      helper.imap("<C-j>", "<Plug>(skkeleton-enable)")
      helper.cmap("<C-j>", "<Plug>(skkeleton-enable)")

      -- 辞書を探す
      local skk_dir = os.getenv "HOME" .. "/.skk"
      local dicts = vim.fn.readdir(skk_dir)
      local dictionaries = {}
      for file in pairs(dicts) do
        table.insert(dictionaries, skk_dir .. "/" .. dicts[file])
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "skkeleton-initialize-pre",
        callback = function()
          vim.fn["skkeleton#config"] {
            eggLikeNewline = true,
            registerConvertResult = true,
            globalDictionaries = dictionaries,
            -- SKK辞書ファイル、及びＧｏｏｇｌｅ日本語入力を使用する
            sources = { "skk_dictionary", "google_japanese_input" },
          }
        end,
      })
    end,
  },
  -- SKKの状態を表示
  { "delphinus/skkeleton_indicator.nvim", opts = {} },
  -- nvim-cmpでSKKの補完を行う
  { "rinx/cmp-skkeleton", dependencies = { "nvim-cmp", "skkeleton" } },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- Inject copilot into cmp sources, with high priority
      table.insert(opts.sources, {
        name = "skkeleton",
        group_index = 1,
        priority = 10000,
      })
    end,
  },
}
