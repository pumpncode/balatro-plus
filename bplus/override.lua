assert(SMODS.load_file("bplus/cardarea.lua"))()

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
