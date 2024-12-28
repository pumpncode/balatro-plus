function bplus_food_jokers_tooltip()
  local nodes = {}
  local centers = {}
  for _, center in pairs(G.P_CENTERS) do
    if center.bplus_food_joker then
      centers[#centers + 1] = center
    end
  end

  local text = {}
  local function add_line(line)
    local parts = {}
    for _, part in ipairs(line) do
      parts[#parts + 1] = { n = G.UIT.T, config = { text = part[1], colour = part[2] or G.C.GREY, scale = 0.33 } }
    end
    text[#text + 1] = {
      n = G.UIT.R,
      config = { align = "cm" },
      nodes = parts,
    }
  end

  local cur_line = {}
  local cur_length = 0
  for i, center in ipairs(centers) do
    local name = localize({ type = "name_text", set = "Joker", key = center.key })
    cur_line[#cur_line + 1] = { name, G.C.ORANGE }
    cur_length = cur_length + #name + 2

    if i == #centers then
      break
    end

    if cur_length > 15 then
      cur_line[#cur_line + 1] = { "," }
      add_line(cur_line)
      cur_line = {}
      cur_length = 0
    else
      cur_line[#cur_line + 1] = { ", " }
    end
  end

  if #cur_line > 0 then
    add_line(cur_line)
  end

  nodes[#nodes + 1] = {
    n = G.UIT.C,
    nodes = text,
  }

  return nodes
end

function bplus_is_blackjack(cards)
  local aces = 0
  local total = 0
  for _, card in ipairs(cards) do
    local id = card:get_id()
    local value = 0
    if id > 10 and id < 14 then
      value = 10
    elseif id == 14 then
      value = 11
      aces = aces + 1
    elseif id > 1 and id < 11 then
      value = id
    end

    if card.debuff then
      value = 0
    end

    total = total + value
  end

  while total > 21 and aces > 0 do
    total = total - 10
    aces = aces - 1
  end

  return total == 21
end

function bplus_open_pack(key)
  stop_use()
  local card = Card(
    G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
    G.CARD_W * 1.27,
    G.CARD_H * 1.27,
    G.P_CARDS.empty,
    G.P_CENTERS[key],
    { bypass_discovery_center = true, bypass_discovery_ui = true }
  )
  card.cost = 0
  G.FUNCS.use_card({ config = { ref_table = card } })
  card:start_materialize()
end

function bplus_get_editions()
  local editions = {}
  for key, center in pairs(G.P_CENTERS) do
    local key = key:match("^e_(.+)")
    if key and key ~= "base" then
      editions[#editions + 1] = key
    end
  end
  return editions
end

function bplus_random_seal(seed_key)
  return pseudorandom_element({
    "Red",
    "Blue",
    "Purple",
    "Gold",
  }, pseudoseed(seed_key))
end

function bplus_random_enhancement(seed_key)
  local enhancements = {}
  for key, center in pairs(G.P_CENTERS) do
    if key:match "m_.+" then
      enhancements[#enhancements + 1] = center
    end
  end
  return pseudorandom_element(enhancements, pseudoseed(seed_key))
end
