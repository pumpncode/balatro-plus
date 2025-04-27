function BPlus.mod.reset_game_globals()
  for key, value in pairs(BPlus.round_vars) do
    G.GAME.current_round["bplus_" .. key] = value(G.GAME.current_round["bplus_" .. key])
  end

  if G.jokers then
    for _, joker in ipairs(G.jokers.cards) do
      local remaining = joker.ability.bplus_debuffed_by_sigil_froze
      if remaining then
        if remaining <= 1 then
          joker.ability.bplus_debuffed_by_sigil_froze = nil
          joker:set_debuff(false)
          joker:set_edition({ negative = true }, true)
        else
          joker.ability.bplus_debuffed_by_sigil_froze = remaining - 1
        end
      end
    end
  end
end

function BPlus.mod.set_debuff(card)
  if card.ability.bplus_debuffed_by_sigil_froze and card.ability.bplus_debuffed_by_sigil_froze > 0 then
    return true
  end
end
