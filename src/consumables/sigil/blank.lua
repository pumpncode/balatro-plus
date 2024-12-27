local s = {
  loc_txt = {
    name = "Blank",
    text = {
      "Use this card after",
      "{C:attention}#1#{} rounds to create",
      "other {C:attention}Sigil{} card",
      "{C:inactive}(Must have room)",
      "{C:inactive}(#2#)",
    },
  },
  config = { extra = { after = 3, remaining = 3 } },
  atlas = 1,
}

function s:loc_vars(_, card)
  return {
    vars = {
      card.ability.extra.after,
      localize {
        type = "variable",
        key = card.ability.extra.remaining == 0 and "loyalty_active" or "loyalty_inactive",
        vars = { card.ability.extra.remaining },
      },
    }
  }
end

function s:can_use(card)
  local cond = card.ability.extra.remaining == 0
  if cond and (card.edition and card.edition.negative) then
    cond = #G.consumeables.cards < G.consumeables.config.card_limit
  end
  return cond
end

function s:use(card)
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
