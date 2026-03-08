-- Core.lua (Lua 5.0 safe)
BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge
local ST = BC.State
local UI = BC.UI

local ADDON = "BoaringChallenge"
local initialized = false

BC.Core = BC.Core or {}
local Core = BC.Core

function Core:Print(msg)
  DEFAULT_CHAT_FRAME:AddMessage(BC:T("CHAT_PREFIX") .. ": " .. msg)
end

Core:Print("v1.0.0 loaded.")

local f = CreateFrame("Frame")
Core.frame = f

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_DEAD")
f:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
f:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")

f:SetScript("OnUpdate", function()
  f._tick = f._tick or 0
  if GetTime() < f._tick then return end
  f._tick = GetTime() + 1
  UI:Refresh()
end)

f:SetScript("OnEvent", function()
  if event == "ADDON_LOADED" and arg1 == ADDON then
    if initialized then return end
    initialized = true

    -- locale first
    BC:InitLocale()

    ST:DBInit()
    UI:UpdateFramePosition()
    UI:SetShown(BoaringChallengeDB.settings.shown ~= false)
    UI:SetLocked(BoaringChallengeDB.settings.locked == true)

    ST:ResetSession()
    Core:Print(BC:T("SESSION_RESET"))

    UI:Refresh()
    return
  end

  if event == "PLAYER_ENTERING_WORLD" then
    UI:UpdateFramePosition()
    UI:Refresh()
    return
  end

  if event == "PLAYER_DEAD" then
    ST:OnDeath()
    UI:Refresh()
    return
  end

  if event == "CHAT_MSG_COMBAT_XP_GAIN" then
    if ST:OnXpGainMessage(arg1) then
      UI:Refresh()
    end
    return
  end

  if event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then
    if ST:OnHostileDeathMessage(arg1) then
      UI:Refresh()
    end
    return
  end
end)