local loadf = function(path)
  return assert(SMODS.load_file("bplus/" .. path .. ".lua"))()
end

BalatroPlus = {
  path = SMODS.current_mod.path:gsub("/$", ""),
}

loadf("override")
loadf("utils")

loadf("joker")("jokers")
loadf("deck")("decks")
