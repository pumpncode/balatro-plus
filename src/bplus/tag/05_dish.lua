return {
  loc_vars = function(self, infoq)
    -- TODO: add food jokers list to {infoq}
  end,

  apply = function(self, tag, ctx)
    if ctx.type == "immediate" then
      tag:yep("+", G.C.ORANGE, function()
        if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
          -- TODO: add food jokers to deck here
        end
        return true
      end)
      tag.triggered = true
      return true
    end
  end,
}
