local mysthic_pack = {
  name = "Mysthic Pack",
  text = {
    "Choose {C:attention}#1#{} of up to",
    "{C:attention}#2#{} {C:bplus_sigil}Sigil{} cards to",
    "be used immediately",
  },
}

local enhancement_tarot_text = {
  "Enhances {C:attention}#1#{}",
  "selected cards to",
  "{C:attention}#2#s",
}

return {
  descriptions = {
    Back = {
      b_bplus_purple = {
        name = "Purple Deck",
        text = {
          "Reroll also refresh {C:attention}Booster Pack{}",
          "reroll cost {C:money}$#1#{} more",
        },
      },
      b_bplus_illusion = {
        name = "Illusion Deck",
        text = {
          "Playing cards has more {C:chips}Chips",
          "start run with {C:attention}#1#{}",
          "random cards destroyed",
        },
      },
      b_bplus_jokered = {
        name = "Jokered Deck",
        text = {
          "Start with {C:money}$#1#{},",
          "{C:attention,T:p_buffoon_jumbo_1}Jumbo Buffoon Pack{}",
          "and {C:attention,T:v_hone}Hone{} voucher",
        },
      },
      b_bplus_mysthical = {
        name = "Mysthical Deck",
        text = {
          "Create a random {C:bplus_sigil}Sigil{} card",
          "when blind is selected",
          "{C:inactive}(Must have room)",
          "Shop {C:attention}slot{} and Shop {C:attention}Booster",
          "{C:attention}Pack{} has {C:attention}1{} less slot",
        },
      },
    },

    Joker = {
      j_bplus_pickpocket = {
        name = "Pickpocket",
        text = {
          "Choose one more card when",
          "opening any {C:attention}Booster pack{}",
        },
      },
    },

    Tarot = {
      c_bplus_rich = { name = "The Rich", text = enhancement_tarot_text },
      c_bplus_craftsman = { name = "The Craftsman", text = enhancement_tarot_text },
      c_bplus_balance = { name = "Balance", text = enhancement_tarot_text },
      c_bplus_hell = { name = "The Hell", text = enhancement_tarot_text },
    },

    Enhanced = {
      m_bplus_premium = {
        name = "Premium Card",
        text = {
          "{X:mult,C:white} X#1# {} Mult",
          "#3# {C:money}$#2#",
        },
      },

      m_bplus_framed = {
        name = "Framed Card",
        text = {
          "Gains {C:chips}+#1#{} Chips",
          "each {C:attention}triggered",
        },
      },

      m_bplus_balanced = {
        name = "Balanced Card",
        text = {
          "{C:attention}Balance{} this card",
          "{C:chips}Chips{} and {C:mult}Mult",
        },
      },

      m_bplus_burned = {
        name = "Burned Card",
        text = {
          "{X:mult,C:white} X#1# {} Mult",
          "If {C:attention}held in hand{} at the",
          "{C:attention}end of round{}, enhance",
          "adjacent card to {C:attention}Burned",
          "{C:attention}Card{} and {C:red}burn{} this card",
        },
      },
    },

    Voucher = {
      v_bplus_refund = {
        name = "Refund",
        text = {
          "Earn {C:money}$#1#{} per {C:attention}choose{}",
          "remaining when any",
          "{C:attention}Booster Pack{} is skipped",
        },
      },
      v_bplus_big_pack = {
        name = "Big Pack",
        text = {
          "{C:attention}Booster Pack{} has",
          "{C:attention}+#1#{} choose and",
          "{C:attention}+#2#{} card slot",
        },
      },
    },

    sigil = {
      c_bplus_sigil_blank = {
        name = "Blank",
        text = {
          "{C:green}#1# in #2#{} chance to",
          "create other {C:attention}Sigil{} card",
          "{s:0.8}chance is increasing",
          "{s:0.8}at the end of round",
          "{C:inactive}(Must have room)",
        },
      },
      c_bplus_sigil_polyc = {
        name = "Polyc",
        text = {
          "Destroy {C:attention}1{} random Joker",
          "to add {C:dark_edition}Polychrome{} to",
          "selected Joker",
        },
      },
      c_bplus_sigil_rebirth = {
        name = "Rebirth",
        text = {
          "Destroy all non {C:dark_edition}negative{}",
          "Jokers to {C:attention}create{} Jokers",
          "with the same amount of",
          "{C:attention}destroyed{} Jokers with",
          "same {C:attention}Rarity",
        },
      },
      c_bplus_sigil_astra = {
        name = "Astra",
        text = {
          "Level up your most played {C:attention}poker",
          "{C:attention}hand{} level by total of all other",
          "{C:attention}poker hands{} level above {C:attention}1{}, resets",
          "other {C:attention}poker hands{} level",
          "{C:inactive}(Currently level up by {C:attention}#1#{C:inactive})",
        },
      },
      c_bplus_sigil_aye = {
        name = "Aye",
        text = {
          "Change up to {C:attention}#1#{} selected",
          "cards {C:attention}rank{} and {C:attention}suits{} to",
          "{C:attention}rank{} and {C:attention}suits{} of random",
          "card in your {C:attention}deck",
        },
      },
      c_bplus_sigil_bann = {
        name = "Bann",
        text = {
          "Destroy all cards with",
          "selected card {C:attention}rank",
          "and {C:attention}suit",
        },
      },
      c_bplus_sigil_beast = {
        name = "Beast",
        text = {
          "Enhance up to {C:attention}#1#{} selected cards",
          "with random {C:attention}Enhancement{} and {C:attention}Seal{}",
          "destroy other {C:attention}unselected{} cards with",
          "same amount of {C:attention}selected{} cards",
        },
      },
      c_bplus_sigil_curse = {
        name = "Curse",
        text = {
          "{C:green}#1# in #2#{} chance to add",
          "any {C:dark_edition}edition{} to random",
          "Joker if {C:red}failed{} add",
          "{C:eternal}Eternal{} and {C:rental}Rental",
        },
      },
      c_bplus_sigil_dupe = {
        name = "Dupe",
        text = {
          "Covert all {C:attention}unselected",
          "cards to {C:attention}selected{} card",
          "{C:blue}-#1#{} Hand",
        },
      },
      c_bplus_sigil_froze = {
        name = "Froze",
        text = {
          "{C:red}Debuff{} selected joker for",
          "{C:attention}#1#{} rounds, become {C:dark_edition}negative{}",
          "after {C:red}debuff{} end",
        },
      },
      c_bplus_sigil_klone = {
        name = "Klone",
        text = {
          "Create copy of up",
          "to {C:attention}#1#{} selected",
          "cards",
        },
      },
      c_bplus_sigil_rewind = {
        name = "Rewind",
        text = {
          "Destroys all {C:attention}Consumables",
          "to fill it with copies of",
          "last used {C:tarot}Tarot{} or",
          "{C:planet}Planet{} card",
        },
      },
      c_bplus_sigil_sacre = {
        name = "Sacre",
        text = {
          "Destroys {C:attention}#1#{} random cards",
          "in your hand, create",
          "a random {C:red}Rare{} Joker",
          "{C:inactive}(Must have room)",
        },
      },
      c_bplus_sigil_shine = {
        name = "Shine",
        text = {
          "Add {C:dark_edition}#1#{} to",
          "selected card",
          "{s:0.8}changes every round",
          "{s:0.8}cannot be {C:dark_edition,s:0.8}negative",
        },
      },
    },

    Other = {
      p_bplus_mysthic_normal1 = mysthic_pack,
      p_bplus_mysthic_normal2 = mysthic_pack,
      p_bplus_mysthic_jumbo = mysthic_pack,
      p_bplus_mysthic_mega = mysthic_pack,

      undiscovered_sigil = {
        name = "Not Dicovered",
        text = {
          "Purchase or use",
          "this card in an",
          "unseeded run to",
          "learn what it does",
        },
      },
    },
  },
  misc = {
    dictionary = {
      b_sigil_cards = "Sigil Cards",
      k_sigil = "Sigil",

      k_bplus_mysthic_pack = "Mysthic Pack",
      k_bplus_ho_ho_ho_ex = "Ho Ho Ho!",
      k_bplus_no_retrigger = "No Retrigger",
      k_bplus_inactive_ex = "Inactive!",
      k_bplus_burn_ex = "Burn!",
    },

    v_dictionary = {
      k_bplus_plus_choose_ex = "+#1# Choose!",
      k_bplus_plus_sigil_ex = "+#1# Sigil!",
    },
  },
}
