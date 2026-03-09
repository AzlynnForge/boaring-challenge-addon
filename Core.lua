-- Core.lua (Lua 5.0 safe)
BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge
local ST = BC.State
local UI = BC.UI

local ADDON = "BoaringChallenge"
local initialized = false

BC.Core = BC.Core or {}
local Core = BC.Core
Core.isEnabled = false
Core.checkingSpellbook = false

function Core:Print(msg)
  DEFAULT_CHAT_FRAME:AddMessage(BC:T("CHAT_PREFIX") .. ": " .. msg)
end

Core:Print("v1.1.0 loaded.")

local f = CreateFrame("Frame")
Core.frame = f

function Core:EnableAddon()
  Core.isEnabled = true
  Core.checkingSpellbook = false

  -- Register tracking events
  f:RegisterEvent("PLAYER_DEAD")
  f:RegisterEvent("PLAYER_LEVEL_UP")
  f:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
  f:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")

  local wasRecreated = ST:DBInit()
  UI:UpdateFramePosition()
  UI:SetShown(BoaringChallengeDB.settings.shown ~= false)
  UI:SetLocked(BoaringChallengeDB.settings.locked == true)

  ST:ResetSession()

  if wasRecreated then
    Core:Print(BC:T("CHARACTER_RECREATED"))
  else
    Core:Print(BC:T("SESSION_RESET"))
  end

  UI:Refresh()
end

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("LEARNED_SPELL_IN_TAB")

f:SetScript("OnUpdate", function()
  f._tick = f._tick or 0
  if GetTime() < f._tick then return end
  f._tick = GetTime() + 1

  -- If we're waiting for spellbook to be ready, check periodically
  if Core.checkingSpellbook then
    if ST:IsSpellbookReady() then
      -- Spellbook is now ready, check for the spell
      if ST:HasBoaringAdventureSpell() then
        Core:EnableAddon()
      else
        -- Spellbook is ready but no "Boaring Adventure" spell
        -- This is not a challenge character
        -- Clear any orphaned data from a previous character with same name
        if BoaringChallengeDB and (BoaringChallengeDB.totalKills or BoaringChallengeDB.characterLevel) then
          BoaringChallengeDB = nil
        end
        -- Hide the UI frame since this character is not on the challenge
        UI.frame:Hide()
        Core.checkingSpellbook = false
      end
    end
    return
  end

  -- Normal UI refresh when addon is enabled
  if Core.isEnabled then
    UI:Refresh()
  end
end)

f:SetScript("OnEvent", function()
  if event == "ADDON_LOADED" and arg1 == ADDON then
    if initialized then return end
    initialized = true

    -- locale first
    BC:InitLocale()

    -- Register PLAYER_ENTERING_WORLD to check spell when character data is loaded
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    return
  end

  if event == "PLAYER_ENTERING_WORLD" then
    -- Check spell on every login until addon is enabled
    if not Core.isEnabled and not Core.checkingSpellbook then
      -- Check if spellbook is ready
      if ST:IsSpellbookReady() then
        -- Spellbook is ready, check for the spell immediately
        if ST:HasBoaringAdventureSpell() then
          Core:EnableAddon()
        else
          -- Spell not found but spellbook is ready - character is not on challenge
          -- Clear any orphaned data from a previous character with same name
          if BoaringChallengeDB and (BoaringChallengeDB.totalKills or BoaringChallengeDB.characterLevel) then
            BoaringChallengeDB = nil
          end
          -- Hide the UI frame since this character is not on the challenge
          UI.frame:Hide()
        end
      else
        -- Spellbook not ready yet (likely new character during/after cinematic)
        -- Start polling via OnUpdate until it's ready
        Core.checkingSpellbook = true
      end
      return
    end

    -- Subsequent PLAYER_ENTERING_WORLD events after enabled (zone changes, etc.)
    if Core.isEnabled then
      UI:UpdateFramePosition()
      UI:Refresh()
    end
    return
  end

  if event == "PLAYER_DEAD" then
    ST:OnDeath()
    UI:Refresh()
    return
  end

  if event == "LEARNED_SPELL_IN_TAB" then
    -- Check if we just learned the Boaring Adventure spell
    if not Core.isEnabled and not Core.checkingSpellbook then
      if ST:HasBoaringAdventureSpell() then
        Core:EnableAddon()
      else
        -- Only clear orphaned data once (after spellbook is reasonably populated)
        -- Check if we have at least 5 spells (character is past initial setup)
        local spellCount = 0
        for i = 1, 50 do
          if GetSpellName(i, BOOKTYPE_SPELL) then
            spellCount = spellCount + 1
          end
        end
        if spellCount >= 5 and BoaringChallengeDB and (BoaringChallengeDB.totalKills or BoaringChallengeDB.characterLevel) then
          BoaringChallengeDB = nil
          -- Hide the UI frame since this character is not on the challenge
          UI.frame:Hide()
        end
      end
    end
    return
  end

  if event == "PLAYER_LEVEL_UP" then
    -- Update stored character level
    if BoaringChallengeDB then
      BoaringChallengeDB.characterLevel = UnitLevel("player")
    end
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