local c = {
  primary_colour = HEX("8e32db"),
  secondary_colour = HEX("6826b2"),
  loc_txt = {
    name = "Sigil",
    collection = "Sigil Cards",
    undiscovered = {
      name = "Not Dicovered",
      text = {
        "Purchase or use",
        "this card in an",
        "unseeded run to",
        "learn what it does",
      },
    },
  },
  shop_rate = 0.05,
  default = "c_bplus_sigil_blank",
  atlas = "consumables/sigils.png",
  cards = {
    "blank",
    "polyc",
    "rebirth",
    "dupe",
    "curse",
    "astra",
    "beast",
  },
}

return c
