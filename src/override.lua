local center_overrides = {
  j_gros_michel = { bplus_food_joker = true },
  j_egg = { bplus_food_joker = true },
  j_ice_cream = { bplus_food_joker = true },
  j_cavendish = { bplus_food_joker = true },
  j_turtle_bean = { bplus_food_joker = true },
  j_popcorn = { bplus_food_joker = true },
  j_ramen = { bplus_food_joker = true },
}

for key, override in pairs(center_overrides) do
  for field, value in pairs(override) do
    G.P_CENTERS[key][field] = value
  end
end

local old_localize = localize
function localize(args, misc_cat)
  if type(args.key) == "table" and args.key.bplus_custom then
    return args.key.bplus_custom(args, misc_cat)
  end
  return old_localize(args, misc_cat)
end

local cardarea_emplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
  if G.jokers then
    for _, j in ipairs(G.jokers.cards) do
      j:calculate_joker({ card_added = true, other_card = card, cardarea = self })
    end
  end
  return cardarea_emplace(self, card, location, stay_flipped)
end

local cardarea_remove_card = CardArea.remove_card
function CardArea:remove_card(card, discarded_only)
  if G.jokers then
    for _, j in ipairs(G.jokers.cards) do
      j:calculate_joker({ card_removed = true, other_card = card, cardarea = self })
    end
  end
  return cardarea_remove_card(self, card, discarded_only)
end

local g_funcs_reroll_shop = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop(e)
  g_funcs_reroll_shop(e)
end
