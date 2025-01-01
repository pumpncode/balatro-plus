local e = {
  loc_txt = {
    name = "Premium Card",
    text = {
      "{X:mult,C:white} X#1# {} Mult",
      "lose {C:money}$#2#",
    },
  },
  config = { Xmult = 2 },
  atlas = 1,
}

BalatroPlus.game_objects.premium_card_cost = 3

function e:loc_vars(_, card)
  return { vars = { card.ability.x_mult, G.GAME.bplus_premium_card_cost } }
end

function e:calculate(card, ctx, effect)
  if ctx.cardarea == G.play and not ctx.repetition then
    effect.p_dollars = -G.GAME.bplus_premium_card_cost
  end
end

return e
