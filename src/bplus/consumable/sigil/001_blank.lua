return {
  config = { extra = 6 },

  loc_vars = function(self, _, card)
    return { vars = { G.GAME.probabilities.normal, card.ability.extra } }
  end,

  can_use = function(self)
    return true
  end,

  use = function(self, card)
    if #G.consumeables.cards >= G.consumeables.config.card_limit then
      return
    end
    if pseudorandom("c_bplus_sigil_blank_create") > G.GAME.probabilities.normal / card.ability.extra then
      return
    end

    play_sound("timpani")
    local area = G.consumeables
    local sig = create_card("sigil", G.pack_cards, nil, nil, nil, nil, nil, "c_bplus_sigil_blank_card")
    sig:add_to_deck()
    area:emplace(sig)
    card:juice_up(0.3, 0.5)
  end,
}
