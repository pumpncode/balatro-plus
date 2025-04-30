return {
  config = { reward = 4 },

  loc_vars = function(self)
    return { vars = { self.config.reward } }
  end,

  apply = function(self, tag, ctx)
    if ctx.type == "eval" then
      tag:yep("+", G.C.MONEY, function()
        return true
      end)
      tag.triggered = true
      return {
        dollars = G.GAME.blind.dollars * self.config.reward,
        condition = "Defeat the Blind",
        pos = tag.pos,
        tag = tag,
      }
    end
  end,
}
