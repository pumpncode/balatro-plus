local e = {
  loc_txt = {
    name = "Premium Card",
    text = {
      "{X:mult,C:white} X#1# {} Mult",
      "#3# {C:money}$#2#",
    },
  },
  config = { Xmult = 2 },
  atlas = 1,
}

BalatroPlus.game_objects.premium_card_dollars = -3

function e:loc_vars()
  local dollars = G.GAME.bplus_premium_card_dollars
  return { vars = { self.config.Xmult, dollars < 0 and -dollars or dollars, dollars < 0 and "Loss" or "Earn" } }
end

function e:calculate(card, ctx, effect)
  if ctx.cardarea == G.play and not ctx.repetition then
    effect.p_dollars = (effect.p_dollars or 0) + G.GAME.bplus_premium_card_dollars
  end
end

return e
