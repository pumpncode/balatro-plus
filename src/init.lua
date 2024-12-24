BalatroPlus = {
  path = SMODS.current_mod.path:gsub("/$", ""),
  load_chace = {},
  G = {},
}

function BalatroPlus.load(path)
  local module = BalatroPlus.load_chace[path]
  if not module then
    module = assert(SMODS.load_file("src/" .. path .. ".lua"))()
    BalatroPlus.load_chace[path] = module
  end
  return module
end

BalatroPlus.load("override")
BalatroPlus.load("utils")

BalatroPlus.load("joker")("jokers")
BalatroPlus.load("deck")("decks")
BalatroPlus.load("blind")("blinds")
BalatroPlus.load("tag")("tags")
