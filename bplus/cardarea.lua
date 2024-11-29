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
