local M = {}

function M.load_object(dir, fn, opt)
  if opt == nil then
    opt = {}
  end

  local row = opt.asset_row or 5
  local atlas = dir:match("/([^/]+)$") or dir
  SMODS.Atlas {
    key = atlas,
    px = opt.px or 71,
    py = opt.py or 95,
    path = dir .. ".png",
    frames = opt.frames,
    atlas_table = opt.frames and "ANIMATION_ATLAS",
  }

  local absdir = BPlus.path .. "/src/bplus/" .. dir
  for _, fname in ipairs(NFS.getDirectoryItems(absdir)) do
    local atlas_number, soul_number, id = fname:match("^(%d+):?(%d*)_([^.]+)%.lua$")
    atlas_number = tonumber(atlas_number)
    soul_number = tonumber(soul_number)
    local obj = load(NFS.read(absdir .. "/" .. fname), fname, "t", _G)()

    if not obj.atlas then
      local n = atlas_number
      obj.atlas = atlas
      local x = n % row
      if x == 0 then
        x = row
      end
      obj.pos = { x = x - 1, y = math.ceil(n / row) - 1 }
    end

    if not obj.soul_pos and soul_number then
      local n = soul_number
      local x = n % row
      if x == 0 then
        x = row
      end
      obj.soul_pos = { x = x - 1, y = math.ceil(n / row) - 1 }
    end

    obj.key = id

    if opt.set then
      obj.set = opt.set
    end

    if opt.cost then
      obj.cost = opt.cost
    end

    if type(obj.unlocked) ~= "boolean" then
      obj.unlocked = true
    end

    obj.discovered = false
    fn(obj)
  end
end

function M.load_consumable(dir, opt)
  opt = opt or {}

  local ct = {
    collection_rows = opt.rows or { 5, 5 },
    default = opt.default,
    cards = {},
    key = dir:match("/([^/]+)$") or dir,
    primary_colour = opt.primary,
    secondary_colour = opt.secondary,
  }

  opt.set = ct.key
  BPlus.u.load_object(dir, function(o)
    o.key = ct.key .. "_" .. o.key
    local _key = "c_bplus_" .. o.key
    ct.cards[_key] = true
    SMODS.Consumable(o)
  end, opt)
  SMODS.ConsumableType(ct)
end

function M.joker_destroyed_trigger(jokers)
  for _, card in ipairs(G.jokers.cards) do
    card:calculate_joker { joker_destroyed = true, destroyed_cards = jokers }
  end
end

function M.random_seal(seed_key)
  return pseudorandom_element({
    "Red",
    "Blue",
    "Purple",
    "Gold",
  }, pseudoseed(seed_key))
end

function M.random_enhancement(seed_key)
  local enhancements = {}
  for key, center in pairs(G.P_CENTERS) do
    if key:match("m_.+") then
      enhancements[#enhancements + 1] = center
    end
  end
  return pseudorandom_element(enhancements, pseudoseed(seed_key))
end

function M.most_played_poker_hand()
  local _planet, _hand, _tally = nil, nil, 0
  for _, handname in ipairs(G.handlist) do
    if G.GAME.hands[handname].visible and G.GAME.hands[handname].played > _tally then
      _hand = handname
      _tally = G.GAME.hands[handname].played
    end
  end
  return _hand
end

function M.get_editions(filter)
  local editions = {}
  for key, _ in pairs(G.P_CENTERS) do
    local key = key:match("^e_(.+)")
    if key and key ~= "base" and (not filter or filter(key)) then
      editions[#editions + 1] = key
    end
  end
  return editions
end

local rarity_table = {
  0, -- Common
  0.71, -- Uncommon
  0.96, -- Rare
}
function M.rarity_to_poll(rarity)
  return rarity_table[rarity] or 0
end

function M.getting_destroyed(c)
  return c.removed or c.destroyed or c.shattered or c.getting_sliced
end

function M.enhancement_tarot(enhancement, max_highlight)
  return {
    config = {
      mod_conv = enhancement,
      max_highlighted = max_highlight or 1,
    },

    loc_vars = function(self, infoq)
      infoq[#infoq + 1] = G.P_CENTERS[self.config.mod_conv]
      return {
        vars = {
          self.config.max_highlighted,
          localize { type = "name_text", set = "Enhanced", key = self.config.mod_conv },
        },
      }
    end,
  }
end

function M.open_pack(key, from_tag)
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
  card.from_tag = from_tag
  G.FUNCS.use_card { config = { ref_table = card } }
  card:start_materialize()
end

function M.get_editions(filter)
  local editions = {}
  for key, center in pairs(G.P_CENTERS) do
    local key = key:match("^e_(.+)")
    if key and key ~= "base" and (not filter or filter(key)) then
      editions[#editions + 1] = key
    end
  end
  return editions
end

return M
