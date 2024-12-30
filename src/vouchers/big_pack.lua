local v = {
  loc_txt = {
    name = "Big Pack",
    text = {
      "{C:attention}Booster pack{} has",
      "{C:attention}+#1#{} choose and",
      "{C:attention}+#2#{} card option",
    },
  },
  config = { choose = 1, extra = 1 },
  requires = {
    "v_bplus_refund",
  },
}

function v:loc_vars()
  return { vars = { self.config.extra, self.config.choose } }
end

return v
