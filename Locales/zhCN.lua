-- Locales/zhCN.lua
BoaringChallenge = BoaringChallenge or {}
local BC = BoaringChallenge
BC.locales = BC.locales or {}

BC.locales["zhCN"] = {
  TITLE = "野猪挑战",

  LINE1 = "野猪：%s（本次）| %s（总计）",
  LINE2 = "时间：%s | 每小时击杀：%s | 每小时经验：%s",
  LINE2_TTL = "时间：%s | 每小时击杀：%s | 每小时经验：%s | 升级剩余：%s",

  LINE3 = "最后击杀：%s（%s秒前）| 平均：%s秒/只",
  LINE4 = "每只经验：%s%s%s",

  AVG10_FMT = "（近10：%s）",
  TO_LEVEL_FMT = " | 距离升级：%s只",
  DEATHS_FMT = " | 死亡：%s",

  CHAT_PREFIX = "|cffa050ffBoaringChallenge|r",
  FRAME_LOCKED = "窗口已锁定",
  FRAME_UNLOCKED = "窗口已解锁",
  SESSION_RESET = "已重置本次统计",
  TOTAL_KILLS_RESET = "总击杀数已重置为0",
  CHARACTER_RECREATED = "检测到角色已重建 - 所有数据已重置",
  NOT_ON_CHALLENGE = "此角色不在野猪挑战中",

  HELP_HEADER = "命令：",
  HELP_SHOW = "  /boar show         - 显示窗口",
  HELP_HIDE = "  /boar hide         - 隐藏窗口",
  HELP_TOGGLE = "  /boar toggle       - 切换显示",
  HELP_RESET = "  /boar reset        - 重置本次统计",
  HELP_RESETTOTAL = "  /boar resettotal   - 重置总击杀数为0",
  HELP_LOCK = "  /boar lock         - 锁定窗口（不可拖动）",
  HELP_UNLOCK = "  /boar unlock       - 解锁窗口（可拖动）",
  HELP_DEATHS = "  /boar deaths 0|1   - 显示/隐藏死亡",
  HELP_TTL = "  /boar ttl 0|1      - 显示/隐藏升级剩余时间",

  UNKNOWN_CMD = "未知命令。请输入 /boar help",

  -- keep English parsing patterns unless you confirm combat text is localized
  PAT_SLAIN = "^You have slain (.-)!$",
  PAT_XPGAIN = "you gain (%d+) experience",
}