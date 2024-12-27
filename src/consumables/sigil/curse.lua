local s = {
  loc_txt = {
    name = "Curse",
    text = {
      "{C:green}#1# in #2#{} chance",
      "to add {C:dark_edition}negative{}",
      "to random Joker if",
      "{C:red}failed{} add {C:eternal}Eternal",
    },
  },
  config = { extra = 4 },
  atlas = 5,
}

function s:loc_vars(infoq, card)
  infoq[#infoq + 1] = G.P_CENTERS.e_negative
  infoq[#infoq + 1] = { key = "eternal", set = "Other" }
  return { vars = { G.GAME.probabilities.normal, card.ability.extra } }
end

function s:can_use(card)
  for _, joker in ipairs(G.jokers.cards) do
    if not joker.edition then
      return true
    end
  end
  return false
end

function s:use(card)
  local negative = pseudorandom("c_bplus_sigil_curse_negative") <= G.GAME.probabilities.normal / card.ability.extra
  local compat_jokers = {}
  for _, joker in ipairs(G.jokers.cards) do
    if not joker.edition then
      compat_jokers[#compat_jokers + 1] = joker
    end
  end

  local joker = pseudorandom_element(compat_jokers, pseudoseed("c_bplus_sigil_curse_joker"))
  if negative then
    joker:set_edition({ negative = true }, true)
  else
    joker:set_eternal(true)
  end
  card:juice_up(0.3, 0.5)
  joker:juice_up(0.2, 0.3)
end

return s
