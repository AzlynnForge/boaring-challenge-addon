# 🐗 BoaringChallenge

A lightweight Vanilla/Turtle WoW addon that tracks your boar grinding performance.

Perfect for long leveling sessions when you just want to know:

- How many boars have I killed?
- How fast am I killing?
- How much XP per hour?
- How many more boars until next level?

---

## ✨ Features

- Session + lifetime boar kill tracking
- Kills per hour (KPH)
- XP per hour (boar-only XP)
- Average seconds per kill
- Rolling average of last 10 kills
- XP per kill (session + last 10)
- Estimated boars remaining until next level
- Optional time-to-level estimate (TTL)
- Optional death counter
- Draggable + lockable UI
- Multi-language support:
  - English
  - French
  - Spanish
  - German
  - Simplified Chinese
  - Korean

---

## 🎮 Supported Clients

Designed for:

- Vanilla 1.12
- Turtle WoW

Lua 5.0 compatible.

---

## 📦 Installation

1. Download or clone this repository.
2. Place the `BoaringChallenge` folder into: "../World of Warcraft/Interface/AddOns/"
3. Launch the game.
4. Enable the addon in the AddOns menu.
5. Type: /boar 

## 🛠 Commands
/boar show
/boar hide
/boar toggle
/boar reset
/boar lock
/boar unlock
/boar deaths 0|1
/boar ttl 0|1


Right-click the frame to quickly toggle lock/unlock.

---

## 🌍 Localization Notes

The addon UI is localized.

⚠ Combat log parsing assumes English combat messages by default.
If your server localizes combat log text, XP parsing patterns may need adjustment in `Locale` files.

---

## 📈 How XP Tracking Works

XP is counted **only when linked to a tracked boar kill**, ensuring:

- Quest XP is ignored
- Exploration XP is ignored
- Non-boar XP is ignored

This keeps metrics accurate for pure grinding sessions.

---

## 🚀 Future Ideas

- Gold per hour tracking
- Session persistence across reload
- Streak tracking
- Hardcore mode support

---

## 📜 License

MIT License

---

Enjoy the grind.