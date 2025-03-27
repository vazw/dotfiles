#!/usr/bin/env python3
# From
# https://www.reddit.com/r/swaywm/comments/c4zb8l/dim_unfocused_windows/es0dg11/.
# This script is a modified version of the one from the link above with
# interrupt handler.

# This script requires i3ipc-python package (install it from a system package
# manager or pip).
# It makes inactive windows transparent. Use `TRANSPARENCY_VALUE` variable to
# control the transparency strength in range of 0…1; 0 is fully transparent.
# The most-recently active window on each monitor stays opaque, not just the
# active window.

import signal
import sys
from typing import Optional

import i3ipc

TRANSPARENCY_VALUE: str = "0.9"
ipc = i3ipc.Connection()
g_prev_focused: Optional[i3ipc.con.Con] = None
g_prev_workspace: int = ipc.get_tree().find_focused().workspace().num

for window in ipc.get_tree():
    if window.focused:
        g_prev_focused = window
    else:
        window.command("opacity " + TRANSPARENCY_VALUE)


def signal_handler(sig, frame):
    for window in ipc.get_tree():
        window.command("opacity 1.0")
    sys.exit(0)


def on_window_focus(ipc: i3ipc.connection.Connection, event: i3ipc.events.WindowEvent):
    global g_prev_focused
    global g_prev_workspace

    focused = event.container
    workspace = ipc.get_tree().find_focused().workspace().num

    # https://github.com/swaywm/sway/issues/2859
    if focused.id != g_prev_focused.id:
        focused.command("opacity 1.0")
        if workspace == g_prev_workspace:
            g_prev_focused.command("opacity " + TRANSPARENCY_VALUE)
        g_prev_focused = focused
        g_prev_workspace = workspace


signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

ipc.on("window::focus", on_window_focus)
# Blocking call.
ipc.main()
