return {
  config = { extra = 1 },
  rarity = 1,
  cost = 5,

  bluprint_compat = true,

  calculate = function(_, self, ctx)
    if ctx.open_booster then
      G.GAME.pack_choices = G.GAME.pack_choices + self.ability.extra
      BPlus.u.status_text(
        self,
        localize { type = "variable", key = "k_bplus_plus_choose_ex", vars = { self.ability.extra } },
        G.C.ORANGE
      )
    end
  end,
}
