#!/bin/bash

session_name="floating_window"
default_dir="$HOME/Downloads"

if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux popup -w 90% -h 80% -E "tmux attach -t $session_name"
else
    tmux new-session -d -s "$session_name" -c "$default_dir"
    tmux popup -w 90% -h 80% -E "tmux attach -t $session_name"
fi
