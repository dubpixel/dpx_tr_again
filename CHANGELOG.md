# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
