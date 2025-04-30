return {
  weight = 0.3,
  cost = 8,
  config = { extra = 4, choose = 1 },
  draw_hand = true,
  kind = "sigil",
  group_key = "k_bplus_mysthic_pack",

  loc_vars = function(self)
    return { vars = { self.config.choose, self.config.extra } }
  end,

  ease_background_colour = function(self)
    ease_background_colour { new_colour = darken(G.C.SECONDARY_SET.sigil, 0.2) }
  end,

  create_card = function(self)
    return create_card("sigil", G.pack_cards, nil, nil, true, true, nil, "p_mysthic_jumbo_card")
  end,
}
