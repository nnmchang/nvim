-- NOTE: indent-tools.nvim の互換性パッチ
--
-- nvim-treesitter-textobjects の main ブランチでは repeatable_move から
-- make_repeatable_move_pair が削除されているが、indent-tools.nvim
-- (arsham/indent-tools.nvim, 9b6a33b 時点) はまだこの関数を呼んでいる。
-- そのままだとセットアップ時に
--   init.lua:106: attempt to call field 'make_repeatable_move_pair' (a nil value)
-- でエラーになり、]i / [i / ii / ai がすべて割り当てられない。
--
-- ここでは make_repeatable_move を使って旧 API を補い、; と , での繰り返しも使えるようにしている。
-- 上流の indent-tools.nvim が main ブランチの API に対応したら、このファイルは削除してよい。
-- (AstroCommunity の astrocommunity.indent.indent-tools-nvim の config を上書きしている)
return {
  "arsham/indent-tools.nvim",
  config = function()
    local ok, rm = pcall(require, "nvim-treesitter-textobjects.repeatable_move")
    if ok and not rm.make_repeatable_move_pair then
      rm.make_repeatable_move_pair = function(forward_fn, backward_fn)
        local move = rm.make_repeatable_move(function(opts)
          if opts.forward then
            forward_fn()
          else
            backward_fn()
          end
        end)
        return function() move { forward = true } end, function() move { forward = false } end
      end
    end

    require("indent-tools").config {}
  end,
}
