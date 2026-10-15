# Global instructions for coding agents

These are agent-agnostic instructions shared across whatever coding
agent I happen to be using (Claude Code, Codex, pi, etc.). This file is
the single source of truth; per-agent config locations are symlinked to
it by `make install`.

## Background jobs and terminal sessions

Three mechanisms. Choose by who reads the output and how long the job must live:

- **Background Bash** (the Bash tool with `run_in_background`): the default
  for a local job whose output the agent reads. The harness tracks the
  process, wakes the agent when it exits, and stops it when the session ends.
  No cleanup is needed.
- **zmx** (https://zmx.sh): persistent *detached* sessions. Use zmx only when
  the job must outlive the Claude session or an SSH disconnect. Examples are
  a job on a remote machine and an overnight local run.
- **cmux**: panes the *user* watches live. Use when the value is in the
  user seeing it unfold in real time — a run being monitored, output being
  eyeballed for a judgment call, anything the user asked to "watch."

Do not use zmx for a local job that finishes inside the session. Escalate to
cmux only when the user has said they want to watch, or when live human
judgment on the streaming output is the point. When unsure which the user
wants, ask before launching — don't guess.

Before using zmx, run `zmx help` to get current syntax — it changes between
versions, so derive commands from help rather than assuming. Do the same for
cmux if its syntax is not already known.

Session naming (zmx and cmux):
- Prefix all agent-spawned sessions with `ai.` so they're separate from the
  user's own sessions. Never kill or attach to the user's sessions.
- Scope related sessions under a shared sub-prefix per task/feature.
  Feature X → `ai.feature-x`, `ai.feature-x.tests`, etc.
- When cleaning up, kill only the relevant group:
  `zmx kill "ai.feature-x.*"` — never `zmx kill "ai.*"`.

Session lifecycle (zmx). A session outlives the command it ran, so an unkilled
session is a zombie. These rules keep the count near zero:
- Create one session per task group, not one per command. `zmx run` runs
  commands sequentially in a session that already exists. Reuse
  `ai.feature-x` for every sequential step. Give a step its own session only
  when it must run at the same time as another step.
- A session holds its output in memory. `zmx history` works only while the
  session lives. The file in the zmx log dir holds daemon lines, not command
  output. Read the output before you kill the session.
- Kill the group in the same step where you report the result:
  `zmx kill "ai.feature-x.*"`. Do not defer it to the end of the conversation.
- Redirect output to a file only when a human must read it after the session
  ends. Write that file into the run directory the job already uses. Do not
  create a log file for each command.
- Before you finish a task, run `zmx list` and kill every `ai.<task>.*`
  session you left. A row with `ended=` and `exit_code=` has finished, so it
  is always safe to kill. A row with no `ended=` is still running. Ask the
  user before you kill a running session.
- Never kill a session without the `ai.` prefix. Those belong to the user.

Remote machines:
- Use zmx sessions there, with the same `ai.` prefix and per-feature scoping.
  Background Bash does not survive an SSH disconnect.
- cmux is for the user's local view; don't assume a watched pane on a remote
  host is visible to the user unless they've set that up.

## Subagents (Agent tool and Workflow tool)

Use the Agent tool or the Workflow tool for useful parallel or specialized
work. Keep the parent agent responsible for coordination and integration.

Do not open cmux surfaces for subagents by default. Use cmux for subagent
coordination only when the user requests visible or interactive sessions.

## Git history and code review

These rules apply to every repository.

Keep the history of a pull request (PR) append-only during development. Add
commits. Do not amend, rebase, squash, or force-push.

When the PR reaches the review stage, make the history clean, bisectable, and
semantic. Each commit holds one semantic change. Each commit builds and passes
its tests on its own. Rewrite history only at this stage. Confirm with the
user before a force-push.

Run `code-review --fix` without being asked. Run it when the implementation
is complete and the focused checks pass. Run it before you report the work as
done and before you open or update a PR. Skip it for read-only work and for
trivial edits. Commit the fixes as new commits, then run the focused checks
again.

## Spawning GLM and Kimi agents via pi

GLM is reached through pi's `amazon-bedrock` provider (there is no working
`zhipu`/`z.ai` provider — don't try it). Models: `zai.glm-5` (default),
`zai.glm-4.7`, `zai.glm-4.7-flash`. Credentials come from the ambient AWS
Bedrock env — no `--api-key` needed.

Kimi is on the same provider: `moonshotai.kimi-k2.5` (default) and
`moonshot.kimi-k2-thinking`. Everything below applies to both families. Confirm
a model id with `pi --list-models <search>` before you launch.

Canonical one-shot invocation (agent consumes the output):

    pi --provider amazon-bedrock --model zai.glm-5 --print --no-session -a "<prompt>"

- `--print` / `-p`: non-interactive, process prompt and exit.
- `--no-session`: ephemeral, don't persist a session file.
- `-a`: trust project-local files (AGENTS.md/CLAUDE.md/extensions) for this run.
- `@file` args inline file contents into the prompt: `... -p @spec.md "review this"`.
- `zai.glm-5` has no thinking mode — omit `--thinking` (it's ignored).
- Need machine-parseable output? add `--mode json`.

Run them as background Bash by default, with `run_in_background` set. The
harness wakes you when the command exits, and you read the output then.

Use zmx only when the agent must outlive the session or run on a remote
machine. Use cmux when the user wants to watch. Both use the `ai.` prefix and
the per-task sub-prefix defined above.

    # zmx, detached, agent reads the result later:
    zmx run ai.<task>.glm1 -d pi --provider amazon-bedrock --model zai.glm-5 --print --no-session -a <prompt>
    zmx wait ai.<task>.glm1                 # block until done
    zmx history ai.<task>.glm1 | tail -100  # read output
    zmx kill ai.<task>.glm1                 # reap it in the same step

Note: `zmx run` passes the command as-is — do NOT wrap the pi command in
quotes, and run one command per session (no parallel sends to one session).
For several GLM agents under zmx, give each its own session:
ai.<task>.glm1, .glm2, …

In a git worktree, pi prints this at startup and still runs normally:

    fatal: <repo>/.git/worktrees: '...' is outside repository at '<cwd>'

It is noise from a git probe, not a launch failure. Judge success by the output
file or the exit code, never by the absence of that line.


## Writing style

Write all prose in Simplified Technical English. The rules are in the file
imported below. It is the single source of truth, and `~/AGENTS.md` and
`~/.codex/AGENTS.md` are symlinks to it.

@~/projects/config/agents/simplified-technical-english.md

## Docstrings

Keep each context-setting preamble to three to five sentences. Remove the
preamble when the code already makes the purpose clear.

Do not use a blanket line limit. Keep measurements, schema traps, compatibility
constraints, and other facts that the code cannot express.

## Machine-specific instructions

Anything specific to one machine — work setup on a dev box, personal
setup on a laptop — goes in `~/AGENTS.local.md`, which is not tracked in
this repo. `make install` creates it empty and never overwrites it, so
each machine keeps its own overrides while this file stays common across
all of them.

@~/AGENTS.local.md
