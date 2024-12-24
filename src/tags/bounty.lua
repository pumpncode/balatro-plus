local t = {
  loc_txt = {
    name = "Bounty Tag",
    text = {
      "Give {X:money,C:white}X#1#{} of the {C:attention}Blinds",
      "reward when defeated",
    },
  },
  config = { reward = 4 },
}

function t:loc_vars()
  return { vars = { self.config.reward } }
end

function t:apply(tag, ctx)
  if ctx.type == "eval" then
    tag:yep("+", G.C.MONEY, function() return true end)
    tag.triggered = true
    return {
      dollars = G.GAME.blind.dollars * self.config.reward,
      condition = "Defeat the Blind",
      pos = tag.pos,
      tag = tag,
    }
  end
end

return t
