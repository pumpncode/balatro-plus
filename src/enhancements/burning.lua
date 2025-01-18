local e = {
  loc_txt = {
    name = "Burning Card",
    text = {
      "{X:mult,C:white} X#1# {} Mult",
      "Enhance adjacent card to",
      "{C:attention}Burning Card{} and {C:red}destroy{} this",
      "card if {C:attention}held in hand{} at",
      "the {C:attention}end of round",
    },
  },
  config = { Xmult = 1.5 },
  atlas = 4,
}

function e:loc_vars()
  return { vars = { self.config.Xmult } }
end

function e:calculate(card, ctx)
  if
    ctx.end_of_round
    and ctx.cardarea == G.hand
    and not ctx.repetition
    and ctx.playing_card_end_of_round
  then
    local left, right
    for i, c in ipairs(ctx.cardarea.cards) do
      if c == card then
        left = ctx.cardarea.cards[i - 1]
        right = ctx.cardarea.cards[i + 1]

        if left and bplus_is_getting_destroyed(left) then
          left = nil
        end
        if right and bplus_is_getting_destroyed(right) then
          right = nil
        end
        break
      end
    end

    if left or right then
      G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0.1,
        func = function()
          if left then
            left:flip()
            play_sound("card1")
            left:juice_up(0.3, 0.3)
          end
          if right then
            right:flip()
            play_sound("card1")
            right:juice_up(0.3, 0.3)
          end
          return true
        end,
      })

      G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0.2,
        func = function()
          if left then
            left:set_ability(self)
          end
          if right then
            right:set_ability(self)
          end
          return true
        end,
      })

      G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0.3,
        func = function()
          if left then
            left:flip()
            play_sound("tarot2")
            left:juice_up(0.3, 0.3)
          end
          if right then
            right:flip()
            play_sound("tarot2")
            right:juice_up(0.3, 0.3)
          end
          return true
        end,
      })
    end

    card.destroyed = true
    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.2,
      func = function ()
        card:start_dissolve({G.C.RED, G.C.ORANGE}, nil, 1.6)
        return true
      end,
    })

    delay(0.6)
  end
end

return e
