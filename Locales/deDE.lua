-- Locales/deDE.lua
BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge
BC.locales = BC.locales or {}

BC.locales["deDE"] = {
  TITLE = "Eber-Herausforderung",

  LINE1 = "Eber: %s (Sitzung) | %s (Gesamt)",
  LINE2 = "Zeit: %s | KPH: %s | XP/h: %s",
  LINE2_TTL = "Zeit: %s | KPH: %s | XP/h: %s | ZBN: %s",

  LINE3 = "Letzter: %s (vor %ss) | Ø: %ss/Kill",
  LINE4 = "XP/Kill: %s%s%s",

  AVG10_FMT = " (10: %s)",
  TO_LEVEL_FMT = " | Bis Level: %s",
  DEATHS_FMT = " | Tode: %s",

  CHAT_PREFIX = "|cffa050ffBoaringChallenge|r",
  FRAME_LOCKED = "Fenster gesperrt",
  FRAME_UNLOCKED = "Fenster entsperrt",
  SESSION_RESET = "Sitzung zurückgesetzt",
  TOTAL_KILLS_RESET = "Gesamt-Kills auf 0 zurückgesetzt",
  CHARACTER_RECREATED = "Charakter neu erstellt erkannt - alle Daten zurückgesetzt",
  NOT_ON_CHALLENGE = "Dieser Charakter hat nicht die Eber-Herausforderung",

  HELP_HEADER = "Befehle:",
  HELP_SHOW = "  /boar show         - Fenster anzeigen",
  HELP_HIDE = "  /boar hide         - Fenster ausblenden",
  HELP_TOGGLE = "  /boar toggle       - umschalten",
  HELP_RESET = "  /boar reset        - Sitzung zurücksetzen",
  HELP_RESETTOTAL = "  /boar resettotal   - Gesamt-Kills auf 0 zurücksetzen",
  HELP_LOCK = "  /boar lock         - Fenster sperren",
  HELP_UNLOCK = "  /boar unlock       - entsperren (verschieben)",
  HELP_DEATHS = "  /boar deaths 0|1   - Tode anzeigen/verbergen",
  HELP_TTL = "  /boar ttl 0|1      - ZBN anzeigen/verbergen",

  UNKNOWN_CMD = "unbekannter Befehl. Nutze /boar help",

  PAT_SLAIN = "^You have slain (.-)!$",
  PAT_XPGAIN = "you gain (%d+) experience",
}