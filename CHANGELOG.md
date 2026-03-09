# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.1.0] - 2026-03-09

### Added
- Character-specific data tracking via `SavedVariablesPerCharacter`
- Automatic Boaring Adventure challenge detection via spellbook check
- Spellbook readiness polling for seamless new character creation
- Automatic character recreation detection with data reset (perfect for Hardcore deaths)
- Manual total kills reset command: `/boar resettotal`
- Orphaned data cleanup when switching from challenge to non-challenge character

### Changed
- Addon now only activates for characters with the "Boaring Adventure" spell
- Data is now stored per-character instead of account-wide
- UI frame is hidden by default and only shown for challenge characters
- Character level tracking for recreation detection

### Technical
- Added `LEARNED_SPELL_IN_TAB` event listener for spell learning detection
- Added `PLAYER_LEVEL_UP` event listener for level tracking
- Implemented spellbook readiness polling system
- Added `IsSpellbookReady()` and `HasBoaringAdventureSpell()` utility functions
- Frame visibility now managed based on challenge detection

## [1.0.0] - 2026-03-08

Initial public release.

### Added
- Session and total boar kill tracking
- XP/hour (boar-only)
- Kills/hour
- Average seconds per kill
- Last 10 kill rolling averages
- XP per kill (session + last 10)
- Estimated boars remaining to level
- Optional time-to-level (TTL)
- Optional death counter
- Draggable + lockable frame
- Multi-language support
- Lua 5.0 compatibility

### Technical
- Modular file structure
- SavedVariables support
- Locale system with fallback