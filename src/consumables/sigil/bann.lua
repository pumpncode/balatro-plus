local s = {
  loc_txt = {
    name = "Bann",
    text = {
      "Destroy all cards with",
      "selected card {C:attention}rank",
      "and {C:attention}suit",
    },
  },
}

function s:can_use()
  return #G.hand.highlighted == 1
end

function s:use(card)
  local selected = G.hand.highlighted[1]
  local destroys = { selected }
  if selected.ability.name ~= G.P_CENTERS.m_stone.name then
    local id, suit = selected:get_id(), selected.base.suit
    for _, card in ipairs(G.playing_cards) do
      if card:get_id() == id and card:is_suit(suit) then
        destroys[#destroys + 1] = card
      end
    end
  end
  for _, card in ipairs(destroys) do
    if card.ability.name == G.P_CENTERS.m_glass.name then
      card:shatter()
    else
      card:start_dissolve()
    end
  end
  G.E_MANAGER:add_event(Event {
    trigger = "after",
    delay = 0.3,
    func = function()
      card:juice_up(0.3, 0.5)
      return true
    end
  })
end

return s
