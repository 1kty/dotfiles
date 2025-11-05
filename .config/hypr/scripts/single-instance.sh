#!/bin/bash


PROCESS="$1"
shift
CMD="$@"

if [ -z "$PROCESS" ] || [ -z "$CMD" ]; then
    echo "Usage: $0 <process_name> <command_to_run>"
    exit 1
fi

if ! pgrep -x "$PROCESS" >/dev/null; then
    $CMD &
fi
