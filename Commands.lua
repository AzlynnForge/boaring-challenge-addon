-- Commands.lua (Lua 5.0 safe)
BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge
local ST = BC.State
local UI = BC.UI
local Core = BC.Core

local function lower(s) return string.lower(s or "") end

SLASH_BOARINGCHALLENGE1 = "/boar"
SLASH_BOARINGCHALLENGE2 = "/boaring"

SlashCmdList["BOARINGCHALLENGE"] = function(msg)
  -- Check if addon is enabled for this character
  if not Core.isEnabled then
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("CHAT_PREFIX") .. ": " .. BC:T("NOT_ON_CHALLENGE"))
    return
  end

  msg = lower(msg or "")
  msg = string.gsub(msg, "^%s+", "")
  msg = string.gsub(msg, "%s+$", "")

  if msg == "" or msg == "help" then
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("CHAT_PREFIX") .. " " .. BC:T("HELP_HEADER"))
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("HELP_SHOW"))
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("HELP_HIDE"))
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("HELP_TOGGLE"))
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("HELP_RESET"))
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("HELP_RESETTOTAL"))
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("HELP_LOCK"))
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("HELP_UNLOCK"))
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("HELP_DEATHS"))
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("HELP_TTL"))
    return
  end

  if msg == "show" then UI:SetShown(true); UI:Refresh(); return end
  if msg == "hide" then UI:SetShown(false); return end
  if msg == "toggle" then UI:SetShown(not BoaringChallengeDB.settings.shown); UI:Refresh(); return end
  if msg == "reset" then ST:ResetSession(); Core:Print(BC:T("SESSION_RESET")); UI:Refresh(); return end
  if msg == "resettotal" or msg == "reset-total" then
    BoaringChallengeDB.totalKills = 0
    Core:Print(BC:T("TOTAL_KILLS_RESET"))
    UI:Refresh()
    return
  end
  if msg == "lock" then UI:SetLocked(true); Core:Print(BC:T("FRAME_LOCKED")); return end
  if msg == "unlock" then UI:SetLocked(false); Core:Print(BC:T("FRAME_UNLOCKED")); return end

  local _, _, k, v = string.find(msg, "^(%S+)%s+(%S+)$")
  if k == "deaths" then
    BoaringChallengeDB.settings.showDeaths = (v == "1" or v == "true" or v == "on")
    UI:Refresh()
    return
  end
  if k == "ttl" then
    BoaringChallengeDB.settings.showTTL = (v == "1" or v == "true" or v == "on")
    UI:Refresh()
    return
  end

  DEFAULT_CHAT_FRAME:AddMessage(BC:T("CHAT_PREFIX") .. ": " .. BC:T("UNKNOWN_CMD"))
end