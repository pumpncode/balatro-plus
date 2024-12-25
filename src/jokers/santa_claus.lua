local j = {
  loc_txt = {
    name = "Santa Claus",
    text = {
      "After each {C:attention}#1#{} rounds played",
      "give a {C:dark_edition}negative{} {C:red}Rare{} Joker",
      "{C:inactive}(#2#)",
    },
  },
  config = {
    extra = {
      remaining = 1,
      every = 1,
    },
  },
  rarity = 2,
  cost = 7,
  atlas = 18,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
  return {
    vars = {
      card.ability.extra.every,
      localize({
        type = "variable",
        key = card.ability.extra.remaining == 0 and "loyalty_active" or "loyalty_inactive",
        vars = { card.ability.extra.remaining },
      }),
    },
  }
end

function j:calculate(card, ctx)
  if ctx.end_of_round and not ctx.individual and not ctx.repetition then
    if not ctx.blueprint then
      card.ability.extra.remaining = card.ability.extra.remaining - 1
    end

    if card.ability.extra.remaining <= 0 then
      G.E_MANAGER:add_event(Event {
        func = function()
          local joker = create_card("Joker", G.jokers, nil, 3, nil, nil, nil, "bplus_santa_claus_gift")
          joker:set_edition({ negative = true }, true)
          joker:add_to_deck()
          G.jokers:emplace(joker)
          joker:start_materialize()
          card.ability.extra.remaining = card.ability.extra.every
          return true
        end
      })
      card_eval_status_text(ctx.blueprint_card or card, 'extra', nil, nil, nil, {
        message = localize('k_plus_joker'),
        colour = G.C.RED,
      })
    end
  end
end

return j
