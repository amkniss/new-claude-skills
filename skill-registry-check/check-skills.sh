#!/bin/bash
# Runs the skill registry validation natively on the Mac and notifies only on drift.
REGISTRY_DIR="${REGISTRY_DIR:-$HOME/Development/_skill-registry}"
LOG_DIR="$HOME/Library/Logs/skill-registry-check"
LOG="$LOG_DIR/last-run.log"
mkdir -p "$LOG_DIR"

notify() {
  /usr/bin/osascript -e "display notification \"$1\" with title \"Skill registry\" sound name \"Glass\""
}

if [ ! -f "$REGISTRY_DIR/sync-skills.py" ]; then
  notify "sync-skills.py not found in $REGISTRY_DIR"
  exit 1
fi

cd "$REGISTRY_DIR" || exit 1
/usr/bin/python3 sync-skills.py --validate > "$LOG" 2>&1
status=$?

# Drift = non-zero exit, or any "drift"/"mismatch"/"missing" line with a non-zero count.
if [ $status -ne 0 ] || grep -Eiq '(drift|mismatch|missing|broken)[^0-9]*[1-9]' "$LOG"; then
  notify "Drift detected. See $LOG"
  exit 2
fi
exit 0
