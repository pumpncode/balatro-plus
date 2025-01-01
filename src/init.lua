BalatroPlus = {
  path = SMODS.current_mod.path:gsub("/$", ""),
  load_chace = {},
  G = {},
  game_objects = {}
}

function BalatroPlus.load(path)
  local module = BalatroPlus.load_chace[path]
  if not module then
    module = assert(SMODS.load_file("src/" .. path .. ".lua"))()
    BalatroPlus.load_chace[path] = module
  end
  return module
end

BalatroPlus.load("override")
BalatroPlus.load("utils")

BalatroPlus.load("joker")("jokers", {
  -- Common
  "pickpocket",
  "archeologist",
  "memory_card",
  "golden_cheese",
  "zombie_hand",
  "ufo",
  "shopping_bill",
  "calculator",
  "boxer",
  "blackjack",
  "treasure_map",
  "wheel",
  "snowman",
  "fragile",
  "chef",
  "stone_skipping",
  "potato_chips",

  -- Uncommon
  "four_leaf_clover",
  "jim130",
  "santa_claus",
  "hungry",
  "magnifying_glass",
  "anonymous_mask",
  "toilet",
  "jackpot",
  "trash_can",
  "stone_carving",

  -- Rare
  "crown",
  "space_invader",
  "blacksmith",
})

BalatroPlus.load("deck")("decks", {
  "purple",
  "illusion",
  "jokered",
})

BalatroPlus.load("blind")("blinds", {
  "extra",
  "hammer",
  "loop",
  "low",
  "thunder",
  "brake",
  "lazy",
  "scales",
  "thirteen",
  "handcuffs",
})

BalatroPlus.load("tag")("tags", {
  "glow",
  "glove",
  "dish",
  "collector",
  "booster",
  "bounty",
})

BalatroPlus.load("consumable")("consumables", {
  "sigil",
})

BalatroPlus.load("booster")("boosters", {
  -- Mysthic Pack for Sigil cards
  "mysthic_normal1",
  "mysthic_normal2",
  "mysthic_jumbo",
  "mysthic_mega",
})

BalatroPlus.load("voucher")("vouchers", {
  "refund",
  "big_pack",
})

function SMODS.current_mod.reset_game_globals()
  for key, value in pairs(BalatroPlus.game_objects) do
    G.GAME.current_round["bplus_" .. key] = value(G.GAME.current_round["bplus_" .. key])
  end
end
