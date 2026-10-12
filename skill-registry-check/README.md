# Skill registry check (local)

Runs `sync-skills.py --validate` on your Mac every day at 9:00 and shows a notification only when drift is found.
Output of the last run: `~/Library/Logs/skill-registry-check/last-run.log`.

## Install
1. Get this folder onto your Mac (`git pull` this branch).
2. Run `bash skill-registry-check/install.sh`
3. Test: `bash skill-registry-check/check-skills.sh && echo in sync`

## Notes
- Assumes the registry lives at `~/Development/_skill-registry` (override with `REGISTRY_DIR`).
- Drift = non-zero exit from the script, or an output line like "drift: 3". If your script's output wording differs, adjust the `grep` line in `check-skills.sh`.
- Uninstall: `launchctl unload ~/Library/LaunchAgents/com.amy.skill-registry-check.plist && rm` that file.
