return function(tag_dir)
  local tags = {}

  for _, file in ipairs(NFS.getDirectoryItems(BalatroPlus.path .. "/src/" .. tag_dir)) do
    if string.match(file, "%.lua$") then
      tags[#tags + 1] = string.gsub(file, "%.lua$", "")
    end
  end

  -- SMODS.Atlas({
  --   key = "tags",
  --   px = 34,
  --   py = 34,
  --   path = "tags.png",
  -- })

  for k, b in pairs(tags) do
    if type(b) == "string" then
      if type(k) == "number" then
        k = b
      end
      b = BalatroPlus.load(tag_dir .. "/" .. b) or b
    end
    if type(b) == "table" then
      if type(b.atlas) == "number" then
        b.pos = { y = b.atlas - 1, x = 0 }
        b.atlas = "tags"
      end

      b.key = k
      b.discovered = false
      SMODS.Tag(b)
    end
  end
end
