local M = {}

M.select_next = function(cmp, snippy)
  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif snippy.can_expand_or_advance() then
      snippy.expand_or_advance()
    else
      fallback()
    end
  end, { "i", "s", "c" })
end

M.select_prev = function(cmp, snippy)
  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif snippy.can_jump(-1) then
      snippy.previous()
    else
      fallback()
    end
  end, { "i", "s", "c" })
end


return M
