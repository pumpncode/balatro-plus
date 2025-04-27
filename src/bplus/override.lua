local game_init_game_object = Game.init_game_object
function Game:init_game_object()
  local ret = game_init_game_object(self)
  for key, value in pairs(BPlus.round_vars) do
    ret.current_round["bplus_" .. key] = value(nil, true)
  end
  return ret
end
