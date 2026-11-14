#!/usr/bin/env bash
# Read stdin, put it on the system clipboard.
# Picks the tool that actually works in the current session: wl-copy needs a
# live Wayland compositor, xclip needs X11. Falls back to discarding stdin so
# copy-pipe still leaves the text in the tmux paste buffer.
if [ -n "$WAYLAND_DISPLAY" ] && command -v wl-copy >/dev/null 2>&1; then
    exec wl-copy
elif [ -n "$DISPLAY" ] && command -v xclip >/dev/null 2>&1; then
    exec xclip -selection clipboard
else
    exec cat >/dev/null
fi
