-- State.lua (Lua 5.0 safe)
BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge

BC.State = BC.State or {}
local ST = BC.State

local function now() return time() end
local function lower(s) return string.lower(s or "") end

ST.RECENT_N = 10
ST.XP_LINK_WINDOW = 3

function ST:IsTrackedMobName(name)
  local n = lower(name)
  return string.find(n, "boar", 1, true) or string.find(n, "goretusk", 1, true) or string.find(n, "swine", 1, true)
end

function ST:IsSpellbookReady()
  -- If we can get at least one spell, spellbook is loaded
  local firstSpell = GetSpellName(1, BOOKTYPE_SPELL)
  return firstSpell ~= nil
end

function ST:HasBoaringAdventureSpell()
  local i = 1
  while true do
    local spellName = GetSpellName(i, BOOKTYPE_SPELL)
    if not spellName then break end
    if spellName == "Boaring Adventure" then
      return true
    end
    i = i + 1
  end
  return false
end

function ST:SecondsToHMS(sec)
  if sec < 0 then sec = 0 end
  local h = math.floor(sec / 3600)
  local rem = sec - (h * 3600)
  local m = math.floor(rem / 60)
  local s = rem - (m * 60)
  return string.format("%02d:%02d:%02d", h, m, s)
end

function ST:FmtInt(n)
  n = tonumber(n) or 0
  local s = tostring(math.floor(n + 0.5))
  local out = ""
  while string.len(s) > 3 do
    out = "," .. string.sub(s, string.len(s) - 2) .. out
    s = string.sub(s, 1, string.len(s) - 3)
  end
  return s .. out
end

function ST:Fmt1(n)
  n = tonumber(n) or 0
  local i = math.floor(n * 10 + 0.5)
  local whole = math.floor(i / 10)
  local frac = i - (whole * 10)
  return tostring(whole) .. "." .. tostring(frac)
end

function ST:KPH(kills, elapsedSec)
  if elapsedSec <= 0 then return 0 end
  return (kills / elapsedSec) * 3600
end

function ST:XPHR(xp, elapsedSec)
  if elapsedSec <= 0 then return 0 end
  return (xp / elapsedSec) * 3600
end

function ST:AvgSecPerKill(kills, elapsedSec)
  if kills <= 0 then return 0 end
  if elapsedSec <= 0 then return 0 end
  return elapsedSec / kills
end

function ST:AvgXpPerKill(xp, kills)
  if kills <= 0 then return 0 end
  return xp / kills
end

function ST:Ceil(n)
  n = tonumber(n) or 0
  local i = math.floor(n)
  if n > i then return i + 1 end
  return i
end

function ST:PushRecent(t, value, maxN)
  table.insert(t, value)
  while table.getn(t) > maxN do
    table.remove(t, 1)
  end
end

function ST:AvgList(t)
  local n = table.getn(t)
  if n <= 0 then return nil end
  local sum = 0
  local i = 1
  while i <= n do
    sum = sum + (tonumber(t[i]) or 0)
    i = i + 1
  end
  return sum / n
end

-- Parsing
function ST:ParseDeathMessage(msg)
  if not msg then return nil end

  local pat = BC:T("PAT_SLAIN")
  local _, _, mob = string.find(msg, pat)
  if mob then return mob end

  -- vanilla fallbacks (still fine)
  _, _, mob = string.find(msg, "^(.-) dies%.$")
  if mob then return mob end
  _, _, mob = string.find(msg, "^(.-) dies!$")
  if mob then return mob end
  _, _, mob = string.find(msg, "^(.-) dies")
  return mob
end

function ST:ParseXpGain(msg)
  if not msg then return nil end
  local pat = BC:T("PAT_XPGAIN")
  local m = string.lower(msg)
  local _, _, xp = string.find(m, pat)
  if xp then
    xp = tonumber(xp)
    -- sanity clamp to prevent garbage
    if xp and xp > 0 and xp < 50000 then
      return xp
    end
  end
  return nil
end

-- SavedVariables
function ST:DBInit()
  if not BoaringChallengeDB then BoaringChallengeDB = {} end

  -- Check if character was recreated (level decreased)
  local currentLevel = UnitLevel("player")
  local storedLevel = BoaringChallengeDB.characterLevel or 0
  local wasRecreated = false

  if storedLevel > 0 and currentLevel < storedLevel then
    -- Character was deleted and recreated - reset all data
    wasRecreated = true
    BoaringChallengeDB = {}
  end

  -- Initialize database
  if not BoaringChallengeDB.totalKills then
    BoaringChallengeDB.totalKills = 0
  end

  if not BoaringChallengeDB.settings then
    BoaringChallengeDB.settings = {
      locked = false,
      shown = true,
      anchor = { point="CENTER", relPoint="CENTER", x=0, y=0 },
      showDeaths = true,
      showTTL = true,
    }
  else
    if BoaringChallengeDB.settings.locked == nil then BoaringChallengeDB.settings.locked = false end
    if BoaringChallengeDB.settings.shown == nil then BoaringChallengeDB.settings.shown = true end
    if not BoaringChallengeDB.settings.anchor then
      BoaringChallengeDB.settings.anchor = { point="CENTER", relPoint="CENTER", x=0, y=0 }
    end
    if BoaringChallengeDB.settings.showDeaths == nil then BoaringChallengeDB.settings.showDeaths = true end
    if BoaringChallengeDB.settings.showTTL == nil then BoaringChallengeDB.settings.showTTL = true end
  end

  -- Update stored level to current level
  BoaringChallengeDB.characterLevel = currentLevel

  return wasRecreated
end

-- Session State
ST.S = ST.S or {
  sessionStart = 0,
  sessionKills = 0,
  sessionXPGained = 0,
  sessionDeaths = 0,

  lastKillName = "—",
  lastKillAt = 0,

  recentXp = {},
  recentDt = {},
  pendingKillAt = 0,
  pendingKillMob = "",
}

function ST:ResetSession()
  local S = ST.S
  S.sessionStart = now()
  S.sessionKills = 0
  S.sessionXPGained = 0
  S.sessionDeaths = 0
  S.lastKillName = "—"
  S.lastKillAt = 0

  S.lastXP = UnitXP("player")
  S.lastXPMax = UnitXPMax("player")

  S.recentXp = {}
  S.recentDt = {}
  S.pendingKillAt = 0
  S.pendingKillMob = ""
end

function ST:OnDeath()
  local S = ST.S
  S.sessionDeaths = S.sessionDeaths + 1
end

function ST:OnXpGainMessage(msg)
  local S = ST.S
  local xp = ST:ParseXpGain(msg)
  if xp < 0 or xp > 5000 then
    return false
  end
  local m = string.lower(msg)
  if not (string.find(m, "boar", 1, true) or string.find(m, "goretusk", 1, true)) then
    return false
  end
  if xp and xp > 0 and S.pendingKillAt and S.pendingKillAt > 0 then
    local dt = now() - S.pendingKillAt
    if dt >= 0 and dt <= ST.XP_LINK_WINDOW then
      ST:PushRecent(S.recentXp, xp, ST.RECENT_N)
    
      -- IMPORTANT: only count XP that is linked to a tracked boar kill
      S.sessionXPGained = S.sessionXPGained + xp
    
      S.pendingKillAt = 0
      S.pendingKillMob = ""
      return true
    end
  end
  return false
end

function ST:OnHostileDeathMessage(msg)
  local mob = ST:ParseDeathMessage(msg)
  if not mob then return false end
  if not ST:IsTrackedMobName(mob) then return false end

  local S = ST.S

  S.sessionKills = S.sessionKills + 1
  BoaringChallengeDB.totalKills = (BoaringChallengeDB.totalKills or 0) + 1
  S.lastKillName = mob

  local t = now()
  if S.lastKillAt and S.lastKillAt > 0 then
    local dt = t - S.lastKillAt
    if dt > 0 and dt <= 120 then
      ST:PushRecent(S.recentDt, dt, ST.RECENT_N)
    end
  end

  S.lastKillAt = t
  S.pendingKillAt = t
  S.pendingKillMob = mob

  return true
end

function ST:TTLText()
  if not BoaringChallengeDB.settings.showTTL then return nil end
  local S = ST.S
  local elapsed = now() - S.sessionStart
  if elapsed < 60 then return nil end

  local rate = ST:XPHR(S.sessionXPGained, elapsed)
  if rate <= 0 then return nil end

  local xp = UnitXP("player")
  local xpMax = UnitXPMax("player")
  local remaining = xpMax - xp
  if remaining <= 0 then return nil end

  local seconds = (remaining / rate) * 3600
  return ST:SecondsToHMS(seconds)
end

function ST:BoarsToLevelText(perKillOverride)
  local S = ST.S
  if S.sessionKills <= 0 then return nil end

  local xp = UnitXP("player")
  local xpMax = UnitXPMax("player")
  local remaining = xpMax - xp
  if remaining <= 0 then return nil end

  local perKill = perKillOverride
  if not perKill or perKill <= 0 then
    perKill = ST:AvgXpPerKill(S.sessionXPGained, S.sessionKills)
  end
  if perKill <= 0 then return nil end

  return tostring(ST:Ceil(remaining / perKill))
end