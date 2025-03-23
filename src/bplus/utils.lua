local M = {}

function M.load_resource(dir, opt, fn)
  if fn == nil and opt then
    fn = opt
    opt = {}
  end

  local row = opt.asset_row or 10
  local atlas = dir:match("/([^/]+)$") or dir
  SMODS.Atlas {
    key = atlas,
    px = opt.px or 71,
    py = opt.py or 95,
    path = dir .. ".png",
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

    if not obj.soul_pos and obj.soul then
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

function M.status_text(card, text, colour)
  card_eval_status_text(card, "jokers", nil, nil, nil, {
    message = text,
    colour = colour,
  })
end

return M
