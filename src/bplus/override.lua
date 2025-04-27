local game_init_game_object = Game.init_game_object
function Game:init_game_object()
  local ret = game_init_game_object(self)
  for key, value in pairs(BPlus.round_vars) do
    ret.current_round["bplus_" .. key] = value(nil, true)
  end
  return ret
end

local cardarea_emplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
  if G.jokers then
    for _, j in ipairs(G.jokers.cards) do
      j:calculate_joker { card_added = true, other_card = card, cardarea = self }
    end
  end
  for _, t in ipairs(G.GAME.tags or {}) do
    t:apply_to_run { type = "card_added", card = card, cardarea = self }
  end
  return cardarea_emplace(self, card, location, stay_flipped)
end

local balatro_add_tag = add_tag
function add_tag(tag)
  local ret = balatro_add_tag(tag)
  if tag.key ~= "tag_bplus_recycle" then
    G.GAME.tag_bplus_recycle_last_tag = tag.key
  end
  return ret
end
