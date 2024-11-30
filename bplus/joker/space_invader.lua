local j = {
  loc_txt = {
    name = "Space Invader",
    text = {
      "{C:planet}Planet{} card added to",
      "{C:attention}Consumable{} become {C:dark_edition}Negative{}",
    },
    unlock = {
      "Have 3 or more {C:planet}Planet{} cards",
      "in your {C:attention}Consumable{} slot",
    },
  },
  rarity = 3,
  cost = 9,
  atlas = 4,
  soul_pos = 5,
}

function j:calculate(_, ctx)
  if ctx.card_added and ctx.cardarea == G.consumeables and ctx.other_card.config.center.set == "Planet" then
    if (not ctx.other_card.edition) or not ctx.other_card.edition.negative then
      ctx.other_card:set_edition({ negative = true }, true)
    end
  end
end

return j
