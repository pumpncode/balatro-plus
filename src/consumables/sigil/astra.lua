local s = {
  loc_txt = {
    name = "Astra",
    text = {
      "Set all {C:attention}poker hand{} level to",
      "level {C:attention}1{} if there is a {C:attention}poker",
      "{C:attention}hand{} with level above {C:attention}#1#{} ",
      "{C:attention}+#2#{} hand size",
    },
  },
  config = { extra = { above = 5, hand_size = 1 } },
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
  update_hand_text(
    { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
    {
      handname = localize("k_all_hands"),
      chips = "...",
      mult = "...",
      level = "",
    }
  )

  G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = 0.2,
    func = function()
      play_sound("tarot1")
      card:juice_up(0.8, 0.5)
      G.TAROT_INTERRUPT_PULSE = true
      return true
    end
  }))

  update_hand_text({ delay = 0 }, { mult = "-", StatusText = true })
  G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = 0.9,
    func = function()
      play_sound("tarot1")
      card:juice_up(0.8, 0.5)
      return true
    end
  }))

  update_hand_text({ delay = 0 }, { chips = "-", StatusText = true })
  G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = 0.9,
    func = function()
      play_sound("tarot1")
      card:juice_up(0.8, 0.5)
      G.TAROT_INTERRUPT_PULSE = nil
      return true
    end
  }))

  update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "1" })
  delay(1.3)
  for k, v in pairs(G.GAME.hands) do
    level_up_hand(card, k, true, -v.level + 1)
  end
  update_hand_text(
    { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
    { mult = 0, chips = 0, handname = "", level = "" }
  )

  G.hand:change_size(card.ability.extra.hand_size)
  G.E_MANAGER:add_event(Event {
    trigger = "after",
    delay = 0.2,
    func = function()
      attention_text {
        text = localize { key = "a_handsize", type = "variable", vars = { card.ability.extra.hand_size } },
        scale = 1.3,
        hold = 1.4,
        major = card,
        backdrop_colour = G.C.SECONDARY_SET.sigil,
        align = "cm",
        offset = { x = 0, y = 0 },
        silent = true,
      }

      G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0.06 * G.SETTINGS.GAMESPEED,
        blockable = false,
        blocking = false,
        func = function()
          play_sound("tarot2", 0.76, 0.4)
          return true
        end
      })

      play_sound("tarot2", 1, 0.4)
      card:juice_up(0.3, 0.5)
      return true
    end
  })
end

return s
