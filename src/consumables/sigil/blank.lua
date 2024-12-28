local s = {
  loc_txt = {
    name = "Blank",
    text = {
      "{C:green}#1# in #2#{} chance to",
      "create other {C:attention}Sigil{} card",
      "{s:0.8}chance is increasing",
      "{s:0.8}at the end of round",
    },
  },
  config = { extra = 6 },
  atlas = 1,
}

function s:loc_vars(_, card)
  return { vars = { G.GAME.probabilities.normal, card.ability.extra } }
end

function s:can_use()
  return true
end

function s:use(card)
  if #G.consumeables.cards >= G.consumeables.config.card_limit then
    return
  end
  if pseudorandom("c_bplus_sigil_blank_create") > G.GAME.probabilities.normal / card.ability.extra then
    return
  end
  G.E_MANAGER:add_event(Event {
    func = function()
      local sigils = {}
      for key, center in pairs(G.P_CENTERS) do
        if key:match("c_bplus_sigil_.+") and key ~= "c_bplus_sigil_blank" then
          sigils[#sigils + 1] = key
        end
      end
      local sigil_key = pseudorandom_element(sigils, pseudoseed("c_bplus_sigil_blank_sigil"))
      local center = G.P_CENTERS[sigil_key]
      play_sound("timpani")
      local area = G.consumeables
      local sig = Card(
        area.T.x + area.T.w / 2,
        area.T.y,
        G.CARD_W,
        G.CARD_H,
        nil,
        center
      )
      sig:start_materialize()
      sig:add_to_deck()
      area:emplace(sig)
      card:juice_up(0.3, 0.5)

      return true
    end
  })
end

return s
