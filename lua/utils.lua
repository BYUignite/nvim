local M = {}

local function clamp(n, min, max)
  return math.max(min, math.min(max, n))
end

function M.hsl_to_hex(h, s, l)
  h = h % 360
  s = clamp(s, 0, 100) / 100
  l = clamp(l, 0, 100) / 100

  local c = (1 - math.abs(2 * l - 1)) * s
  local x = c * (1 - math.abs((h / 60) % 2 - 1))
  local m = l - c / 2

  local r, g, b
  if h < 60 then
    r, g, b = c, x, 0
  elseif h < 120 then
    r, g, b = x, c, 0
  elseif h < 180 then
    r, g, b = 0, c, x
  elseif h < 240 then
    r, g, b = 0, x, c
  elseif h < 300 then
    r, g, b = x, 0, c
  else
    r, g, b = c, 0, x
  end

  local function channel(v)
    return clamp(math.floor((v + m) * 255 + 0.5), 0, 255)
  end

  return string.format("#%02x%02x%02x", channel(r), channel(g), channel(b))
end

return M
