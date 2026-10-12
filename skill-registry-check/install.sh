#!/bin/bash
# Installs a daily launchd job (9:00) that runs check-skills.sh.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/Library/LaunchAgents/com.amy.skill-registry-check.plist"
chmod +x "$HERE/check-skills.sh"
sed "s|__SCRIPT__|$HERE/check-skills.sh|" "$HERE/com.amy.skill-registry-check.plist" > "$DEST"
launchctl unload "$DEST" 2>/dev/null || true
launchctl load "$DEST"
echo "Installed. Test now with: $HERE/check-skills.sh && echo 'in sync'"
