# Global instructions for Claude Code

## Terminal sessions: use zmx

zmx (https://zmx.sh) provides persistent detached terminal sessions.
Use it for long-running commands.

Before using zmx, run `zmx help` to get current syntax — it changes
between versions, so derive the commands from help rather than assuming.

Session naming:
- Prefix all agent-spawned sessions with `ai.` so they're separate
  from the user's own sessions. Never kill the user's sessions.
- Scope related sessions under a shared sub-prefix per task/feature.
  Working on feature X → name sessions `ai.feature-x`, `ai.feature-x.tests`, etc.
- When cleaning up, kill only the relevant group, not everything:
  `zmx kill "ai.feature-x.*"` — not `zmx kill "ai.*"`.

Remote machines:
- When working on a remote machine, use zmx sessions there too, with
  the same `ai.` prefix and per-feature scoping rules.

## Machine-specific instructions

Anything specific to one machine — work setup on a dev box, personal
setup on a laptop — goes in `~/.claude/CLAUDE.local.md`, which is not
tracked in this repo. `make install` creates it empty and never
overwrites it, so each machine keeps its own overrides while this file
stays common across all of them.

@~/.claude/CLAUDE.local.md
