from libqtile.config import Key
from libqtile.lazy import lazy

from qconst import mod, terminal

keymaps = [
    Key(
        [mod],
        "h",
        lazy.layout.left(),
        desc="Move focus to left",
    ),
    Key(
        [mod],
        "l",
        lazy.layout.right(),
        desc="Move focus to right",
    ),
    Key(
        [mod],
        "j",
        lazy.layout.down(),
        desc="Move focus down",
    ),
    Key(
        [mod],
        "k",
        lazy.layout.up(),
        desc="Move focus up",
    ),
    Key(
        [mod],
        "space",
        lazy.layout.next(),
        desc="Move window focus to other window",
    ),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down",
    ),
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        desc="Move window up",
    ),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down(),
        desc="Grow window down",
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up(),
        desc="Grow window up",
    ),
    Key(
        [mod],
        "n",
        lazy.layout.normalize(),
        desc="Reset all window sizes",
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Toggle between different layouts as defined below
    Key(
        [mod],
        "Tab",
        lazy.next_layout(),
        desc="Toggle between layouts",
    ),
    Key(
        [mod],
        "w",
        lazy.window.kill(),
        desc="Kill focused window",
    ),
    Key(
        [mod, "control"],
        "r",
        lazy.reload_config(),
        desc="Reload the config",
    ),
    Key(
        [mod, "control"],
        "q",
        lazy.shutdown(),
        desc="Shutdown Qtile",
    ),
    Key(
        [mod],
        "Return",
        lazy.spawn(terminal),
        desc="Launch terminal",
    ),
    Key(
        [mod, "shift"],
        "e",
        lazy.spawn("rofi-emacs"),
        desc="Launch rofi menu for emacs stuff",
    ),
    Key(
        [mod],
        "e",
        lazy.spawn("emacsclient -c -a 'emacs'"),
        desc="Launch emacsclient",
    ),
    Key(
        [mod],
        "b",
        lazy.spawn("librewolf"),
        desc="Launch web browser",
    ),
    Key(
        [mod, "shift"],
        "b",
        lazy.hide_show_bar(),
        desc="Toggle visibility of the bar",
    ),
    # IO control stuff
    Key(
        [],
        "Print",
        # lazy.spawn("flameshot gui"),
        lazy.spawn("rofi-screenshot"),
        desc="Launch screenshot program",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("amixer -q sset PCM,0 1+ unmute"),
        desc="Increase audio volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("amixer -q sset PCM,0 1- unmute"),
        desc="Decrease audio volume",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("amixer -q sset PCM,0 toggle"),
        desc="Mute out audio volume",
    ),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl set +5%"),
        desc="Increase display brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl set 5%-"),
        desc="Decrease display brightness",
    ),
    Key(
        [mod, "shift"],
        "c",
        lazy.spawn("local-change-wallpaper"),
        desc="Decrease display brightness",
    ),
    Key(
        [mod, "shift"],
        "q",
        lazy.spawn("rofi-powermenu"),
        desc="Launch power menu",
    ),
    Key(
        [mod],
        "o",
        lazy.spawn("rofi-open-file"),
        desc="Launch dmenu file opener",
    ),
    Key(
        [mod],
        "r",
        lazy.spawn("rofi-pass"),
        desc="Get password from password manager",
    ),
    Key(
        [mod],
        "p",
        lazy.spawn("rofi-launcher"),
        desc="Launch run menu",
    ),
    Key(
        [mod, "shift"],
        "p",
        lazy.spawn("rofi-runner"),
        desc="Run an executable",
    ),
    Key(
        [mod],
        "m",
        lazy.spawn("rofi-mpd"),
        desc="Mpd control",
    ),
    Key(
        [mod],
        "f",
        lazy.spawn("pcmanfm"),
        desc="Launch GUI file manager",
    ),
    Key(
        [mod, "shift", "control"],
        "l",
        lazy.spawn("betterlockscreen -l dim"),
        desc="Lock screen",
    ),
]
