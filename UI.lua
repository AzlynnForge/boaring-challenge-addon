-- UI.lua (Lua 5.0 safe)
BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge

BC.UI = BC.UI or {}
local UI = BC.UI
local ST = BC.State

UI.frame = CreateFrame("Frame", "BoaringChallengeFrame", UIParent)
local frame = UI.frame

-- Hide by default - only shown when addon is enabled for challenge characters
frame:Hide()

-- Color helpers (WoW color codes)
local C = {
  reset = "|r",
  purple = "|cffa050ff",  -- matches your title tone
  white = "|cffffffff",
  grey = "|cffc8c8c8",
  green = "|cff3cff3c",
  gold = "|cffffd100",
  red = "|cffff6060",
  teal = "|cff40e0d0",
}

local function colorize(color, text)
  return (color or "") .. (text or "") .. C.reset
end

frame:SetWidth(280)
frame:SetHeight(92)
frame:SetFrameStrata("MEDIUM")
frame:SetMovable(true)
frame:EnableMouse(true)

frame.bg = frame:CreateTexture(nil, "BACKGROUND")
frame.bg:SetAllPoints(frame)
frame.bg:SetTexture(0, 0, 0, 0.55)

frame.border = CreateFrame("Frame", nil, frame)
frame.border:SetAllPoints(frame)
frame.border:SetBackdrop({ edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 12 })
frame.border:SetBackdropBorderColor(0.6, 0.2, 1.0, 0.95)

local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -6)
title:SetText("|cffa050ff" .. BC:T("TITLE") .. "|r")

local line1 = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
line1:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -26)
line1:SetJustifyH("LEFT")

local line2 = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
line2:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -42)
line2:SetJustifyH("LEFT")

local line3 = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
line3:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -58)
line3:SetJustifyH("LEFT")

local line4 = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
line4:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -74)
line4:SetJustifyH("LEFT")

function UI:UpdateFramePosition()
  local a = BoaringChallengeDB.settings.anchor
  frame:ClearAllPoints()
  frame:SetPoint(a.point, UIParent, a.relPoint, a.x, a.y)
end

function UI:SetLocked(isLocked)
  BoaringChallengeDB.settings.locked = isLocked and true or false
end

function UI:SetShown(shown)
  BoaringChallengeDB.settings.shown = shown and true or false
  if BoaringChallengeDB.settings.shown then frame:Show() else frame:Hide() end
end

frame:SetScript("OnMouseDown", function()
  if BoaringChallengeDB.settings.locked then return end
  frame:StartMoving()
end)

frame:SetScript("OnMouseUp", function(_, button)
  if button == "RightButton" then
    UI:SetLocked(not BoaringChallengeDB.settings.locked)
    DEFAULT_CHAT_FRAME:AddMessage(BC:T("CHAT_PREFIX") .. ": " .. (BoaringChallengeDB.settings.locked and BC:T("FRAME_LOCKED") or BC:T("FRAME_UNLOCKED")))
    return
  end

  if BoaringChallengeDB.settings.locked then return end
  frame:StopMovingOrSizing()
  local point, _, relPoint, x, y = frame:GetPoint(1)
  BoaringChallengeDB.settings.anchor = { point=point, relPoint=relPoint, x=x, y=y }
end)

function UI:Refresh()
  if not BoaringChallengeDB.settings.shown then return end

  local S = ST.S
  local elapsed = time() - S.sessionStart
  local recentSpk = ST:AvgList(S.recentDt)
  local recentXpk = ST:AvgList(S.recentXp)

  -- Line 1
  local sKills = colorize(C.white, ST:FmtInt(S.sessionKills))
  local tKills = colorize(C.white, ST:FmtInt(BoaringChallengeDB.totalKills))

  line1:SetText(string.format(BC:T("LINE1"), sKills, tKills))

-- Line 2
local kphVal = colorize(C.green, tostring(math.floor(ST:KPH(S.sessionKills, elapsed) + 0.5)))
local xphrVal = colorize(C.green, ST:FmtInt(ST:XPHR(S.sessionXPGained, elapsed)))

local ttl = ST:TTLText()
if ttl then
  local ttlVal = colorize(C.teal, ttl)
  line2:SetText(string.format(BC:T("LINE2_TTL"),
    ST:SecondsToHMS(elapsed),
    kphVal,
    xphrVal,
    ttlVal
  ))
else
  line2:SetText(string.format(BC:T("LINE2"),
    ST:SecondsToHMS(elapsed),
    kphVal,
    xphrVal
  ))
end

-- Line 3
local sinceLast = (S.lastKillAt > 0) and (time() - S.lastKillAt) or 0

local mobName = colorize(C.purple, S.lastKillName)
local sinceTxt = colorize(C.grey, ST:FmtInt(sinceLast))

local spk = ST:AvgSecPerKill(S.sessionKills, elapsed)
local spkText = colorize(C.white, ST:Fmt1(spk))

if recentSpk then
  spkText = spkText .. colorize(C.grey, string.format(BC:T("AVG10_FMT"), ST:Fmt1(recentSpk)))
end

line3:SetText(string.format(BC:T("LINE3"),
  mobName,
  sinceTxt,
  spkText
))

-- Line 4
local xpk = ST:AvgXpPerKill(S.sessionXPGained, S.sessionKills)
local xpkText = colorize(C.white, ST:Fmt1(xpk))
if recentXpk then
  xpkText = xpkText .. colorize(C.grey, string.format(BC:T("AVG10_FMT"), ST:Fmt1(recentXpk)))
end

local btl = ST:BoarsToLevelText(recentXpk)
local btlText = ""
if btl then
  local label = string.format(BC:T("TO_LEVEL_FMT"), "%s")
  local goldVal = colorize(C.gold, btl)
  btlText = string.format(label, goldVal)
end

local deathText = ""
if BoaringChallengeDB.settings.showDeaths then
  local label = string.format(BC:T("DEATHS_FMT"), "%s")
  local redVal = colorize(C.red, ST:FmtInt(S.sessionDeaths))
  deathText = string.format(label, redVal)
end

line4:SetText(string.format(BC:T("LINE4"),
  xpkText, btlText, deathText
))
  
  -- Frame sugar
  local maxWidth = 0
  maxWidth = math.max(maxWidth, line1:GetStringWidth())
  maxWidth = math.max(maxWidth, line2:GetStringWidth())
  maxWidth = math.max(maxWidth, line3:GetStringWidth())
  maxWidth = math.max(maxWidth, line4:GetStringWidth())

  frame:SetWidth(maxWidth + 20)
  frame:SetAlpha(0.95)
end