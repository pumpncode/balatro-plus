local cmod = SMODS.current_mod

-- add src directory to package path
local path = cmod.path:gsub("/$", "")
package.path = package.path .. string.format(";%s/src/?.lua;%s/src/?/init.lua", path, path)

BPlus = {
  u = require("bplus.utils"),
  mod = cmod,
  path = path,
  round_vars = {},
  config = SMODS.current_mod.config,
  config_ui = {
    { label = "Replace Splash Logo", type = "toggle", mod_config = "replace_splash_logo" },
  },
}

SMODS.Atlas {
  key = "balatro_plus",
  path = "balatro_plus.png",
  px = G.ASSET_ATLAS.balatro.px,
  py = G.ASSET_ATLAS.balatro.py,
}

SMODS.Atlas {
  key = "modicon",
  path = "modicon.png",
  px = 39,
  py = 39,
}

function BPlus.update_splash_logo()
  local key = "balatro"
  if BPlus.config.replace_splash_logo then
    key = "bplus_balatro_plus"
  end

  if G.SPLASH_LOGO then
    G.SPLASH_LOGO.atlas = G.ASSET_ATLAS[key]
  end
end

require("bplus.uidef")
require("bplus.funcs")

BPlus.u.load_object("joker", SMODS.Joker)

BPlus.u.load_consumable("consumable/sigil", {
  cost = 4,
  primary = HEX("8e32db"),
  secondary = HEX("5524b0"),
  rows = { 3, 4 },
  default = "c_bplus_sigil_blank",
})
BPlus.u.load_object("booster", SMODS.Booster, { asset_row = 4 })

local game_init_game_object = Game.init_game_object
function Game:init_game_object()
  local ret = game_init_game_object(self)
  for key, value in pairs(BPlus.round_vars) do
    ret.current_round["bplus_" .. key] = value(nil, true)
  end
  return ret
end

function cmod.reset_game_globals()
  for key, value in pairs(BPlus.round_vars) do
    G.GAME.current_round["bplus_" .. key] = value(G.GAME.current_round["bplus_" .. key])
  end

  if G.jokers then
    for _, joker in ipairs(G.jokers.cards) do
      local remaining = joker.ability.bplus_debuffed_by_sigil_froze
      if remaining then
        if remaining <= 1 then
          joker.ability.bplus_debuffed_by_sigil_froze = nil
          joker:set_debuff(false)
          joker:set_edition({ negative = true }, true)
        else
          joker.ability.bplus_debuffed_by_sigil_froze = remaining - 1
        end
      end
    end
  end
end

function cmod.set_debuff(card)
  if card.ability.bplus_debuffed_by_sigil_froze and card.ability.bplus_debuffed_by_sigil_froze > 0 then
    return true
  end
end
