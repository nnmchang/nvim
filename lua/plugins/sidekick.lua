-- sidekick.nvim の追加設定(本体は community.lua の astrocommunity.ai.sidekick-nvim で読み込む)
---@type LazySpec
return {
  "folke/sidekick.nvim",
  opts = {
    -- NES(Copilot LSP による次の編集の提案)は使わないので無効にする。
    -- Claude などの AI CLI 連携には影響しない
    nes = { enabled = false },
  },
}
