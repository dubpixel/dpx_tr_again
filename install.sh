#!/bin/sh
# ================================================================================
# SHELL SCRIPT - LOCAL INSTALLER FOR TesseraRemoteAgain.app
# ================================================================================
# PROJECT: dpx_tr_again
# ================================================================================
#
# File: install.sh
# Purpose: Build TesseraRemoteAgain.app locally (default: ~/Applications).
#          Creating the app here, instead of unzipping a download, means no
#          transfer damage and no Gatekeeper quarantine flag.
# Usage:   curl -fsSL https://raw.githubusercontent.com/dubpixel/dpx_tr_again/main/install.sh | sh
#          ./install.sh [destination-folder]
# Dependencies: macOS (curl, plutil optional)
#
# CHANGE LOG: see CHANGELOG.md
#
# ================================================================================
set -eu

VERSION="0.3.1"                 # keep in sync with VERSION (build.sh checks)
DEST="${1:-$HOME/Applications}"
APP="$DEST/TesseraRemoteAgain.app"
ICON_URL="https://raw.githubusercontent.com/dubpixel/dpx_tr_again/v${VERSION}/assets/AppIcon.icns"

mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"

# --- launcher (build.sh verifies this matches src/TesseraRemoteAgain) ---------
cat > "$APP/Contents/MacOS/TesseraRemoteAgain" <<'LAUNCHER_EOF'
#!/bin/sh
# ================================================================================
# SHELL SCRIPT - TESSERA REMOTE LAUNCHER
# ================================================================================
# PROJECT: dpx_tr_again
# ================================================================================
#
# File: TesseraRemoteAgain
# Purpose: Open a NEW instance of the highest-versioned "Tessera Remote*.app"
#          found in /Applications or ~/Applications.
# Dependencies: macOS (open, osascript), sort -V
#
# CHANGE LOG: see CHANGELOG.md
#
# ================================================================================

TAB=$(printf '\t')

# List "<app name><TAB><full path>" for every install, then version-sort on the
# NAME only. Sorting whole paths would let the folder prefix decide the winner
# instead of the version. sort -V ranks 3.10.0 above 3.5.2 (plain sort doesn't).
APP=$(
  for dir in /Applications "$HOME/Applications"; do
    for a in "$dir"/Tessera\ Remote*.app; do
      [ -d "$a" ] && printf '%s\t%s\n' "${a##*/}" "$a"
    done
  done | sort -V -t "$TAB" -k1,1 | tail -1 | cut -f2
)

# Show a dialog rather than failing silently: when launched from the .app
# wrapper there is no terminal to see an error in.
if [ -z "$APP" ]; then
  osascript -e 'display alert "Tessera Remote not found" message "Looked in /Applications and ~/Applications."'
  exit 1
fi

# -n opens a new instance even if one is already running (the whole point:
# macOS refuses a second copy of a running app otherwise).
open -n "$APP"
LAUNCHER_EOF
chmod +x "$APP/Contents/MacOS/TesseraRemoteAgain"

cat > "$APP/Contents/Info.plist" <<PLIST_EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleExecutable</key><string>TesseraRemoteAgain</string>
  <key>CFBundleIdentifier</key><string>tv.dubpixel.TesseraRemoteAgain</string>
  <key>CFBundleName</key><string>TesseraRemoteAgain</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleInfoDictionaryVersion</key><string>6.0</string>
  <key>CFBundleIconFile</key><string>AppIcon</string>
  <key>CFBundleShortVersionString</key><string>$VERSION</string>
  <key>CFBundleVersion</key><string>$VERSION</string>
</dict>
</plist>
PLIST_EOF

# Icon is optional: if it can't be fetched (offline, or run from a checkout that
# has assets/), the app still works with the generic icon.
HERE=$(cd "$(dirname "$0")" 2>/dev/null && pwd || true)
if [ -n "$HERE" ] && [ -f "$HERE/assets/AppIcon.icns" ]; then
  cp "$HERE/assets/AppIcon.icns" "$APP/Contents/Resources/AppIcon.icns"
else
  curl -fsSL "$ICON_URL" -o "$APP/Contents/Resources/AppIcon.icns" 2>/dev/null \
    || echo "note: could not fetch icon; using the default one"
fi

# Nudge Finder to pick up the new bundle/icon.
touch "$APP"
echo "Installed: $APP"
open -R "$APP" 2>/dev/null || true
