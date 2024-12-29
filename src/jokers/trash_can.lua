local j = {
  loc_txt = {
    name = "Trash Can",
    text = {
      "Retrigger all playing",
      "card when {C:red}discarded{}",
    },
  },
  config = { extra = 1 },
  rarity = 2,
  cost = 6,

  blueprint_compat = true,
}

function j:calculate(card, ctx)
  if ctx.discard_repetition then
    return {
      message = localize("k_again_ex"),
      repetitions = card.ability.extra,
    }
  end
end

return j
