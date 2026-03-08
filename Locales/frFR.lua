-- Locales/frFR.lua
BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge
BC.locales = BC.locales or {}

BC.locales["frFR"] = {
  TITLE = "Défi Sanglier",

  LINE1 = "Sangliers : %s (session) | %s (total)",
  LINE2 = "Temps : %s | KPH : %s | XP/h : %s",
  LINE2_TTL = "Temps : %s | KPH : %s | XP/h : %s | TNL : %s",

  LINE3 = "Dernier : %s (il y a %ss) | Moy : %ss/kill",
  LINE4 = "XP/kill : %s%s%s",

  AVG10_FMT = " (10 : %s)",
  TO_LEVEL_FMT = " | Jusqu'au niveau : %s",
  DEATHS_FMT = " | Morts : %s",

  CHAT_PREFIX = "|cffa050ffBoaringChallenge|r",
  FRAME_LOCKED = "fenêtre verrouillée",
  FRAME_UNLOCKED = "fenêtre déverrouillée",
  SESSION_RESET = "session réinitialisée",

  HELP_HEADER = "commandes :",
  HELP_SHOW = "  /boar show      - afficher la fenêtre",
  HELP_HIDE = "  /boar hide      - masquer la fenêtre",
  HELP_TOGGLE = "  /boar toggle    - afficher/masquer",
  HELP_RESET = "  /boar reset     - réinitialiser la session",
  HELP_LOCK = "  /boar lock      - verrouiller la fenêtre",
  HELP_UNLOCK = "  /boar unlock    - déverrouiller (déplacer)",
  HELP_DEATHS = "  /boar deaths 0|1 - afficher/masquer les morts",
  HELP_TTL = "  /boar ttl 0|1    - afficher/masquer TNL",

  UNKNOWN_CMD = "commande inconnue. Essayez /boar help",

  -- Keep English parsing patterns unless you confirm Turtle sends localized combat text
  PAT_SLAIN = "^You have slain (.-)!$",
  PAT_XPGAIN = "you gain (%d+) experience",
}