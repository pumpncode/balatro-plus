local cmod = SMODS.current_mod

-- add src directory to package path
local path = cmod.path:gsub("/$", "")
package.path = package.path .. string.format(";%s/src/?.lua;%s/src/?/init.lua", path, path)

BPlus = {
  u = require("bplus.utils"),
  path = path,
}

BPlus.u.load_object("joker", SMODS.Joker)

BPlus.u.load_consumable("consumable/sigil", {
  cost = 4,
  primary = HEX("8e32db"),
  secondary = HEX("5524b0"),
  rows = { 3, 4 },
  default = "c_bplus_sigil_blank",
})
BPlus.u.load_object("booster", { row = 4 }, SMODS.Booster)
