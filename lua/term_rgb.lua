local M = {}

local function read_response(tty)
  local buf = ""
  local max = 4096
  local n = 0
  while n < max do
    local c = tty:read(1)
    if not c or c == "\007" then
      break
    end
    if c == "\27" then
      local nextc = tty:read(1)
      if nextc == "\\" then
        break
      end
      buf = buf .. c .. (nextc or "")
    else
      buf = buf .. c
    end
    n = n + 1
  end
  return buf
end

---@param color_part string 0-4 digit color part from OSC 4 response
---@return string 2-digit hex code part
local function normalize_rgb_part(color_part)
  if #color_part == 2 then
    return color_part
  elseif #color_part >= 2 then
    return color_part:sub(1, 2)
  elseif #color_part == 1 then
    return color_part .. color_part
  end

  return "00"
end

---@param tty file
---@param color int
---@return string?
local function get_rgb(tty, color)
  local q = string.format("\27]4;%d;?\7", color)
  -- write query
  local ok2, _ = pcall(function()
    tty:write(q)
    tty:flush()
  end)

  if not ok2 then
    return
  end

  local resp = read_response(tty)

  -- Try to parse #rrggbb
  local hex = resp:match("#(%x%x%x%x%x%x)")
  if hex then
    return "#" .. hex
  end

  -- Try to parse rgb:Rrrr/Gggg/Bbbb
  local r, g, b = resp:match("rgb:([%x]+)/([%x]+)/([%x]+)")
  if r and g and b then
    r = normalize_rgb_part(r)
    g = normalize_rgb_part(g)
    b = normalize_rgb_part(b)
    return ("#%s%s%s"):format(r, g, b)
  end
end

---@param colors table<string, int> color name to terminal color index
---@return table<string, string> hex color code or original color name
function M.get_rgb(colors)
  local results = {}

  local tty, err = io.open("/dev/tty", "r+")
  if err or not tty then
    vim.notify(err or "unknown")
    for name in pairs(colors) do
      results[name] = name
    end
    return results
  end

  for name, idx in pairs(colors) do
    results[name] = get_rgb(tty, idx) or name
  end

  tty:close()
  return results
end

return M
