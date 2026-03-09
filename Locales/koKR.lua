-- Locales/koKR.lua
BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge
BC.locales = BC.locales or {}

BC.locales["koKR"] = {
  TITLE = "멧돼지 도전",

  LINE1 = "멧돼지: %s (세션) | %s (총합)",
  LINE2 = "시간: %s | KPH: %s | XP/시: %s",
  LINE2_TTL = "시간: %s | KPH: %s | XP/시: %s | 레벨업까지: %s",

  LINE3 = "마지막: %s (%s초 전) | 평균: %s초/킬",
  LINE4 = "XP/킬: %s%s%s",

  AVG10_FMT = " (10: %s)",
  TO_LEVEL_FMT = " | 레벨업까지: %s마리",
  DEATHS_FMT = " | 죽음: %s",

  CHAT_PREFIX = "|cffa050ffBoaringChallenge|r",
  FRAME_LOCKED = "프레임 잠금",
  FRAME_UNLOCKED = "프레임 잠금 해제",
  SESSION_RESET = "세션 초기화",
  TOTAL_KILLS_RESET = "총 킬 수 0으로 초기화",
  CHARACTER_RECREATED = "캐릭터 재생성 감지 - 모든 데이터 초기화",
  NOT_ON_CHALLENGE = "이 캐릭터는 멧돼지 도전에 참여하지 않습니다",

  HELP_HEADER = "명령어:",
  HELP_SHOW = "  /boar show         - 프레임 표시",
  HELP_HIDE = "  /boar hide         - 프레임 숨김",
  HELP_TOGGLE = "  /boar toggle       - 표시 전환",
  HELP_RESET = "  /boar reset        - 세션 초기화",
  HELP_RESETTOTAL = "  /boar resettotal   - 총 킬 수 0으로 초기화",
  HELP_LOCK = "  /boar lock         - 프레임 잠금",
  HELP_UNLOCK = "  /boar unlock       - 프레임 잠금 해제(이동)",
  HELP_DEATHS = "  /boar deaths 0|1   - 죽음 표시/숨김",
  HELP_TTL = "  /boar ttl 0|1      - TTL 표시/숨김",

  UNKNOWN_CMD = "알 수 없는 명령어입니다. /boar help 를 사용하세요",

  PAT_SLAIN = "^You have slain (.-)!$",
  PAT_XPGAIN = "you gain (%d+) experience",
}