# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

---

## [0.3.2] - 2026-11-02

### Added
- GitHub Actions workflow that builds and tests the app on macOS 14 and 15 (Apple Silicon) using fake Tessera Remote apps, plus a smoke test that downloads the real Tessera Remote 3.5.2 DMG and checks two simultaneous instances open (Intel natively, Apple Silicon via Rosetta). Fake-app checks: picks the highest version, opens multiple instances, shows the not-found alert, DMG contents

### Changed
- README explains the "shell script inside an app" concept, how to build the app by hand, and what the extra code adds (location + version arbitration)

### Fixed
- `src/TesseraRemoteAgain.app` Info.plist version and `AGENTS.md` version line were out of sync

---

## [0.3.1] - 2026-11-02

### Changed
- First GitHub Release (with `.dmg` and `.zip` assets). The `v0.3.0` tag predates the installer merge, so use v0.3.1 or later.

---

## [0.3.0] - 2026-11-02

### Added
- `install.sh`: builds the app locally into `~/Applications` (no transfer damage, no Gatekeeper quarantine); runnable via `curl | sh`
- `build.sh`: builds the `.app`, `.zip` and `.dmg` (drag-to-Applications) into git-ignored `dist/`
- `assets/AppIcon.icns` (extracted from the original app's custom icon) used by the app via `Info.plist`

### Removed
- `src/TesseraRemoteAgain.zip` from the repo; the zip/dmg are now Release assets

---

## [0.2.2] - 2026-11-02

### Added
- `Info.plist` in the `.app` bundle
- README section on getting past Gatekeeper for emailed/downloaded copies

### Changed
- Launcher also searches `~/Applications`, and version-sorts on the app name so the folder doesn't affect which version wins
- "Not found" alert names the folders searched

---

## [0.2.1] - 2026-11-01

### Changed
- README explains what the launcher does and why (multiple Tessera Remote instances on macOS), with search keywords
- `AGENTS.md` PROJECT block filled in
- Site title and description in `_config.yml`

---

## [0.2.0] - 2026-11-01

### Added
- GitHub Pages auto-deploy workflow (`.github/workflows/pages.yml`)

---

## [0.1.1] - 2026-11-01

### Added
- MIT license (commercial use allowed, attribution required)
- `VERSION` file

### Changed
- Launcher opens the highest-versioned `Tessera Remote*.app` in `/Applications` instead of a hardcoded 3.5.2
- Launcher shows an alert if no Tessera Remote is installed
- Rebuilt `TesseraRemoteAgain.zip` with `ditto` (no `__MACOSX` junk)

---

## [0.1.0] - 2026-11-01

### Added
- Initial import: launcher script and `.app` wrapper (hardcoded to Tessera Remote 3.5.2)

---

## Version Guidelines

### Semantic Versioning (MAJOR.MINOR.PATCH)

- **MAJOR**: Breaking changes, incompatible API modifications
- **MINOR**: New features, backwards-compatible additions
- **PATCH**: Bug fixes, documentation updates, typos

### Change Categories

- **Added**: New features or capabilities
- **Changed**: Changes to existing functionality
- **Deprecated**: Features marked for future removal (still working)
- **Removed**: Removed features or functionality
- **Fixed**: Bug fixes
- **Security**: Security patches or vulnerability fixes

### Example Entry Format

```markdown
## [1.2.0] - 2026-03-15

### Added
- New authentication system with JWT tokens
- Export functionality for CSV and JSON formats
- Dark mode toggle in user preferences

### Changed
- Improved database query performance by 40%
- Updated UI library from v2.1 to v3.0

### Fixed
- Fixed memory leak in background worker process
- Corrected timezone handling in date picker component

### Security
- Patched XSS vulnerability in user input validation
```

### Version Comparison Links

Add these at the bottom of the file (replace with your repo owner/name):

```markdown
[Unreleased]: https://github.com/owner/repo/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/owner/repo/releases/tag/v0.1.0
```

---

## Tips for Maintaining This Changelog

1. **Update as you work**: Add entries when making changes, not at release time
2. **Keep it scannable**: Use clear, concise descriptions
3. **Link to issues/PRs**: Include `(#123)` references when relevant
4. **Date format**: Use ISO 8601 (YYYY-MM-DD)
5. **Group by type**: Keep all Added items together, all Fixed items together, etc.
6. **User perspective**: Write what changed for users, not implementation details
7. **Unreleased section**: Keep active changes here, move to version section on release
