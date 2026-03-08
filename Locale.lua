-- Locale.lua (Lua 5.0 safe)
BoaringChallengeDB = BoaringChallengeDB or {}

BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge

BC.locales = BC.locales or {}
BC.locale = nil
BC.strings = nil

function BC:InitLocale()
  local loc = GetLocale() or "enUS"
  -- DEV override
  --local loc = "frFR"
  BC.locale = loc

  local tbl = BC.locales[loc]
  if not tbl then
    tbl = BC.locales["enUS"]
  end
  BC.strings = tbl or {}
end

function BC:T(key)
  if not BC.strings then
    BC:InitLocale()
  end
  local v = BC.strings[key]
  if v == nil then
    -- fallback to the key itself so missing strings are obvious
    return tostring(key)
  end
  return v
end