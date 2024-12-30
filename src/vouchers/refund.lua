local v = {
  loc_txt = {
    name = "Refund",
    text = {
      "Earn {C:money}$#1#{} per {C:attention}choose{}",
      "remaining when any",
      "{C:attention}Booster pack{} is skipped",
    },
  },
  config = { money = 2 },
}

function v:loc_vars()
  return { vars = { self.config.money } }
end

return v
