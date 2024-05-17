local source_name_comparator = function(entry1, entry2)
  if entry1.source.name ~= "nvim_lsp" then
    if entry2.source.name == "nvim_lsp" then
      return false
    else
      return nil
    end
  end
  return nil
end

local underline_label_comparator = function(entry1, entry2)
  -- labels beginning with "_" are placed after all others .
  local entry1_private = entry1.completion_item.label:match "^_" ~= nil
  local entry2_private = entry2.completion_item.label:match "^_" ~= nil
  if entry1_private ~= entry2_private then return entry2_private end
  return nil
end

local lspkind_comparator = function(conf)
  local lsp_types = require("cmp.types").lsp
  return function(entry1, entry2)
    -- priority sort
    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]
    if kind1 == "Variable" and entry1:get_completion_item().label:match "%w*=" then kind1 = "Parameter" end
    if kind2 == "Variable" and entry2:get_completion_item().label:match "%w*=" then kind2 = "Parameter" end

    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0
    if priority1 == priority2 then return nil end
    return priority2 < priority1
  end
end

-- standard label sort
local label_comparator = function(entry1, entry2) return entry1.completion_item.label < entry2.completion_item.label end

return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    opts.formatting = {
      format = function(entry, vim_item)
        if vim.tbl_contains({ "path" }, entry.source.name) then
          local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
          if icon then
            vim_item.kind = icon
            vim_item.kind_hl_group = hl_group
            return vim_item
          end
        end
        return require("lspkind").cmp_format { mode = "symbol_text", with_text = true }(entry, vim_item)
      end,
    }
    opts.sorting = {
      comparators = {
        source_name_comparator,
        underline_label_comparator,
        lspkind_comparator {
          kind_priority = {
            Parameter = 14,
            Variable = 12,
            Field = 11,
            Property = 11,
            Constant = 10,
            Enum = 10,
            EnumMember = 10,
            Event = 10,
            Function = 10,
            Method = 10,
            Operator = 10,
            Reference = 10,
            Struct = 10,
            File = 8,
            Folder = 8,
            Class = 5,
            Color = 5,
            Module = 5,
            Keyword = 2,
            Constructor = 1,
            Interface = 1,
            Snippet = 0,
            Text = 1,
            TypeParameter = 1,
            Unit = 1,
            Value = 1,
          },
        },
        label_comparator,
      },
    }
  end,
}
