#!/bin/sh
# SessionStart hook. Prints the host name and, inside a zmx session, the
# session name. Claude Code shows the "systemMessage" under the startup banner.
msg="host: $(hostname -s)"
[ -n "$ZMX_SESSION" ] && msg="$msg · zmx: $ZMX_SESSION"
printf '{"systemMessage": "%s"}\n' "$msg"
