#!/bin/sh
# ================================================================================
# SHELL SCRIPT - BUILD TesseraRemoteAgain.app, .zip AND .dmg
# ================================================================================
# PROJECT: dpx_tr_again
# ================================================================================
#
# File: build.sh
# Purpose: Build everything from ONE source (src/TesseraRemoteAgain + VERSION +
#          assets/AppIcon.icns) into dist/ (git-ignored; attach the .dmg/.zip to a
#          GitHub Release) and refresh the tracked bundle in src/.
# Usage:   ./build.sh
# Dependencies: macOS (ditto, hdiutil, plutil)
#
# CHANGE LOG: see CHANGELOG.md
#
# ================================================================================
set -eu
cd "$(dirname "$0")"

VERSION=$(cat VERSION)
OUT=dist
NAME=TesseraRemoteAgain
APP="$OUT/$NAME.app"

# Guard: install.sh embeds the launcher and a version; fail loudly if stale.
grep -q "^VERSION=\"$VERSION\"" install.sh || { echo "install.sh VERSION != $VERSION"; exit 1; }
EMBED=$(sed -n "/<<'LAUNCHER_EOF'/,/^LAUNCHER_EOF/p" install.sh | sed '1d;$d')
[ "$EMBED" = "$(cat "src/$NAME")" ] || { echo "install.sh launcher differs from src/$NAME (re-embed it)"; exit 1; }

rm -rf "$OUT"
# Build the app by running the installer itself, so there is one code path.
sh ./install.sh "$OUT" >/dev/null
plutil -lint "$APP/Contents/Info.plist" >/dev/null

# Refresh the tracked bundle in src/ (keeps its custom-icon file untouched).
cp "$APP/Contents/MacOS/$NAME" "src/$NAME.app/Contents/MacOS/$NAME"
cp "$APP/Contents/Info.plist"  "src/$NAME.app/Contents/Info.plist"
mkdir -p "src/$NAME.app/Contents/Resources"
cp "$APP/Contents/Resources/AppIcon.icns" "src/$NAME.app/Contents/Resources/AppIcon.icns"  # Info.plist points at it

# zip: ditto preserves permissions and metadata.
ditto -c -k --sequesterRsrc --keepParent "$APP" "$OUT/$NAME-v$VERSION.zip"

# dmg: app + /Applications shortcut for drag-to-install.
STAGE="$OUT/dmg"
mkdir -p "$STAGE"
cp -R "$APP" "$STAGE/"
ln -s /Applications "$STAGE/Applications"
hdiutil create -quiet -volname "$NAME $VERSION" -srcfolder "$STAGE" -ov -format UDZO "$OUT/$NAME-v$VERSION.dmg"
rm -rf "$STAGE"

echo "Built in $OUT/:"; ls -1 "$OUT"
