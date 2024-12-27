local s = {
  loc_txt = {
    name = "Astra",
    text = {
      "Set random {C:attention}poker hand{} level",
      "with level above {C:attention}#1#{} to {C:attention}1",
      "{C:attention}+#2#{} hand size",
    },
  },
  config = { extra = { above = 12, hand_size = 1 } },
  atlas = 6,
}

function s:loc_vars(_, card)
  return { vars = { card.ability.extra.above, card.ability.extra.hand_size } }
end

function s:can_use(card)
  for _, hand in pairs(G.GAME.hands) do
    if hand.level > card.ability.extra.above then
      return true
    end
  end
  return false
end

function s:use(card)
  local hands = {}
  for name, hand in pairs(G.GAME.hands) do
    if hand.level > card.ability.extra.above then
      hands[#hands + 1] = { name = name, info = hand }
    end
  end

  local hand = pseudorandom_element(hands, pseudoseed("c_bplus_sigil_astra_hand"))

  update_hand_text(
    { sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
    {
      handname = localize(hand.name, 'poker_hands'),
      chips = hand.info.chips,
      mult = hand.info.mult,
      level = hand.info.level,
    }
  )
  level_up_hand(card, hand.name, nil, -hand.info.level + 1)
  update_hand_text(
    { sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
    { mult = 0, chips = 0, handname = '', level = '' }
  )

  G.hand:change_size(card.ability.extra.hand_size)
  card_eval_status_text(card, 'extra', nil, nil, nil, {
    message = localize { key = "a_handsize", type = "variable", vars = { card.ability.extra.hand_size } },
    colour = G.C.ORANGE,
  })
  card:juice_up(0.3, 0.5)
end

return s
