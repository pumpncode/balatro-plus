local j = {
  loc_txt = {
    name = "Mirror",
    text = {
      "When {C:attention}Boss Blind{} is selected",
      "absorb {C:attention}Boss Blind{} ability to",
      "good version of it when this",
      "Joker is the {C:attention}left most{}",
      "{S:0.8}only work once{}",
    },
  },
  config = { extra = { ability = false } },
  rarity = 3,
  cost = 9,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
  local boss = card.ability.extra.ability and G.P_BLINDS[card.ability.extra.ability]
  local main_end = boss and {
    {
      n = G.UIT.C,
      config = { align = "bm", minh = 0.4 },
      nodes = {
        {
          n = G.UIT.C,
          config = { align = "m", colour = boss.boss_colour, r = 0.05, padding = 0.06 },
          nodes = {
            { n = G.UIT.B, config = { w = 0.1, h = 0.1 } },
            { n = G.UIT.T, config = { text = boss.name, colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
            { n = G.UIT.B, config = { w = 0.1, h = 0.1 } },
          }
        }
      }
    }
  }
  return { main_end = main_end }
end

function j:calculate(card, ctx)
  if ctx.setting_blind and not card.getting_sliced and ctx.blind.boss and not card.ability.extra.ability and G.jokers.cards[1] == card then
    G.E_MANAGER:add_event(Event({
      func = function()
        G.E_MANAGER:add_event(Event({
          func = function()
            if not G.GAME.blind.disabled then
              G.GAME.blind:disable()
              play_sound('timpani')
              delay(0.4)
            end
            return true
          end
        }))

        card.ability.extra.ability = G.GAME.blind.config.blind.key
        card_eval_status_text(card, "jokers", nil, nil, nil, {
          message = "Absorb!",
          colour = G.P_BLINDS[card.ability.extra.ability].boss_colour,
        })
        return true
      end
    }))
  end
  if card.ability.extra.ability then
    --TODO
  end
end

return j
