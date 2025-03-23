local cmod = SMODS.current_mod

-- add src directory to package path
local path = cmod.path:gsub("/$", "")
package.path = package.path .. string.format(";%s/src/?.lua;%s/src/?/init.lua", path, path) 

BPlus = {
  u = require("bplus.utils"),
  path = path,
}

BPlus.u.load_resource("joker", SMODS.Joker)
