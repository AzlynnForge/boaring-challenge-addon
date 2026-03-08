-- Locales/enUS.lua
BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge
BC.locales = BC.locales or {}

BC.locales["enUS"] = {
  TITLE = "Boaring Challenge",

  LINE1 = "Boars: %s (session) | %s (total)",
  LINE2 = "Time: %s | KPH: %s | XP/hr: %s",
  LINE2_TTL = "Time: %s | KPH: %s | XP/hr: %s | TTL: %s",

  LINE3 = "Last kill: %s (%ss ago) | Avg: %ss/kill",
  LINE4 = "XP/kill: %s%s%s",

  AVG10_FMT = " (10: %s)",
  TO_LEVEL_FMT = " | To level: %s",
  DEATHS_FMT = " | Deaths: %s",

  CHAT_PREFIX = "|cffa050ffBoaringChallenge|r",
  FRAME_LOCKED = "frame locked",
  FRAME_UNLOCKED = "frame unlocked",
  SESSION_RESET = "session reset",

  HELP_HEADER = "commands:",
  HELP_SHOW = "  /boar show      - show frame",
  HELP_HIDE = "  /boar hide      - hide frame",
  HELP_TOGGLE = "  /boar toggle    - toggle frame",
  HELP_RESET = "  /boar reset     - reset session counters",
  HELP_LOCK = "  /boar lock      - lock frame (no dragging)",
  HELP_UNLOCK = "  /boar unlock    - unlock frame (drag to move)",
  HELP_DEATHS = "  /boar deaths 0|1 - show/hide deaths line item",
  HELP_TTL = "  /boar ttl 0|1    - show/hide time-to-level estimate",

  UNKNOWN_CMD = "unknown command. Try /boar help",

  -- patterns for parsing chat (keep English; localized clients may differ)
  PAT_SLAIN = "^You have slain (.-)!$",
  PAT_XPGAIN = "you gain (%d+) experience",
}