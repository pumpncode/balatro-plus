local g_funcs_evaluate_play = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play(e)
  local ret = g_funcs_evaluate_play(e)
  G.GAME.blind:hand_played()
  return ret
end

function Blind:hand_played()
  if type(self.config.blind.hand_played) == "function" then
    self.config.blind.hand_played(self)
  end
end

return function(blind_dir)
  local decks = {}

  for _, file in ipairs(NFS.getDirectoryItems(BalatroPlus.path .. "/src/" .. blind_dir)) do
    if string.match(file, "%.lua$") then
      decks[#decks + 1] = string.gsub(file, "%.lua$", "")
    end
  end

  SMODS.Atlas({
    key = "blinds",
    px = 34,
    py = 34,
    path = "blinds.png",
    atlas_table = "ANIMATION_ATLAS",
    frames = 21,
  })

  for k, b in pairs(decks) do
    if type(b) == "string" then
      if type(k) == "number" then
        k = b
      end
      b = BalatroPlus.load(blind_dir .. "/" .. b) or b
    end
    if type(b) == "table" then
      if type(b.atlas) == "number" then
        b.pos = { y = b.atlas - 1, x = 0 }
        b.atlas = "blinds"
      end

      b.key = k
      b.discovered = false
      SMODS.Blind(b)
    end
  end
end
