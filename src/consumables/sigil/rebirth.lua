local s = {
  loc_txt = {
    name = "Rebirth",
    text = {
      "Destroy all Jokers to",
      "{C:attention}create{} Jokers with the",
      "same amount of {C:attention}destroyed",
      "Jokers with same {C:attention}Rarity",
    },
  },
  atlas = 3,
}

function s:can_use(card)
  local compat = 0
  for _, joker in ipairs(G.jokers.cards) do
    if not joker.ability.eternal then
      compat = compat + 1
    end
  end
  return compat > 0
end

function s:use(card)
  G.E_MANAGER:add_event(Event {
    func = function()
      local rarities = {}
      play_sound('slice1', 0.96 + math.random() * 0.08)
      for _, joker in ipairs(G.jokers.cards) do
        if not joker.ability.eternal then
          rarities[#rarities + 1] = joker.config.center.rarity
          joker:start_dissolve()
        end
      end

      G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0.5,
        func = function()
          play_sound("timpani")
          for _, rarity in ipairs(rarities) do
            local joker = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "c_bplus_sigil_rebirth_joker", {
              forced_rarity = rarity,
            })
            joker:add_to_deck()
            G.jokers:emplace(joker)
            joker:start_materialize()
          end
          card:juice_up(0.3, 0.5)
          return true
        end
      })

      return true
    end
  })
end

return s
