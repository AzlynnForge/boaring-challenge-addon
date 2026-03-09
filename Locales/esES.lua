-- Locales/esES.lua
BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge
BC.locales = BC.locales or {}

BC.locales["esES"] = {
  TITLE = "Desafío Jabalí",

  LINE1 = "Jabalíes: %s (sesión) | %s (total)",
  LINE2 = "Tiempo: %s | KPH: %s | XP/h: %s",
  LINE2_TTL = "Tiempo: %s | KPH: %s | XP/h: %s | TNS: %s",

  LINE3 = "Último: %s (hace %ss) | Prom: %ss/kill",
  LINE4 = "XP/kill: %s%s%s",

  AVG10_FMT = " (10: %s)",
  TO_LEVEL_FMT = " | Para nivel: %s",
  DEATHS_FMT = " | Muertes: %s",

  CHAT_PREFIX = "|cffa050ffBoaringChallenge|r",
  FRAME_LOCKED = "marco bloqueado",
  FRAME_UNLOCKED = "marco desbloqueado",
  SESSION_RESET = "sesión reiniciada",
  TOTAL_KILLS_RESET = "muertes totales reiniciadas a 0",
  CHARACTER_RECREATED = "personaje recreado detectado - todos los datos reiniciados",
  NOT_ON_CHALLENGE = "Este personaje no está en el Desafío Jabalí",

  HELP_HEADER = "comandos:",
  HELP_SHOW = "  /boar show         - mostrar marco",
  HELP_HIDE = "  /boar hide         - ocultar marco",
  HELP_TOGGLE = "  /boar toggle       - alternar marco",
  HELP_RESET = "  /boar reset        - reiniciar sesión",
  HELP_RESETTOTAL = "  /boar resettotal   - reiniciar muertes totales a 0",
  HELP_LOCK = "  /boar lock         - bloquear marco",
  HELP_UNLOCK = "  /boar unlock       - desbloquear (mover)",
  HELP_DEATHS = "  /boar deaths 0|1   - mostrar/ocultar muertes",
  HELP_TTL = "  /boar ttl 0|1      - mostrar/ocultar TNS",

  UNKNOWN_CMD = "comando desconocido. Prueba /boar help",

  PAT_SLAIN = "^You have slain (.-)!$",
  PAT_XPGAIN = "you gain (%d+) experience",
}