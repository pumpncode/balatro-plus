local old_localize = localize
function localize(args, misc_cat)
  if type(args.key) == "table" and args.key.bplus_custom then
    return args.key.bplus_custom(args, misc_cat)
  end
  return old_localize(args, misc_cat)
end

assert(SMODS.load_file("bplus/override.lua"))()
assert(SMODS.load_file("bplus/utils.lua"))()

local path = SMODS.current_mod.path
local jokers = {}

for _, file in ipairs(NFS.getDirectoryItems(path .. "/bplus/joker")) do
  jokers[#jokers+1] = string.gsub(file, "%.lua$", '')
end

SMODS.Atlas {
  key = "jokers",
  px = 71,
  py = 95,
  path = "jokers.png",
}

for k, j in pairs(jokers) do
  if type(j) == "string" then
    if type(k) == "number" then
      k = j
    end
    j = assert(SMODS.load_file("bplus/joker/" .. j .. ".lua"))() or j
  end
  if type(j) == "table" then
    if type(j.atlas) == "number" then
      local n = j.atlas
      j.atlas = "jokers"
      local x = n % 5
      if x == 0 then
        x = 5
      end
      j.pos = { x = x - 1, y = math.ceil(n / 5) - 1 }
    end

    if type(j.soul_pos) == "number" then
      local n = j.soul_pos
      local x = n % 5
      if x == 0 then
        x = 5
      end
      j.soul_pos = { x = x - 1, y = math.ceil(n / 5) - 1 }
    end

    j.key = k
    if type(j.unlocked) ~= "boolean" then
      j.unlocked = true
    end
    j.discovered = false
    SMODS.Joker(j)
  end
end
