#!/usr/bin/env python

from libqtile import hook
from libqtile.config import Click, Drag, DropDown
from libqtile.config import Key, Match, ScratchPad, Screen
from libqtile.layout.columns import Columns
from libqtile.layout.floating import Floating
from libqtile.layout.max import Max
from libqtile.layout.stack import Stack
from libqtile.layout.xmonad import MonadTall
from libqtile.lazy import lazy

from qbar import bar
from qkeys import keymaps
from qcolors import onedark
from qgroups import workspaces
from qconst import mod, terminal

keys = keymaps
groups = workspaces

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    i.name
                ),
            ),
            Key(
                [mod, "control"],
                i.name,
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    Columns(
        border_normal=onedark["color16"],
        border_focus=onedark["color5"],
        border_width=2,
        border_normal_stack=onedark["color16"],
        border_focus_stack=onedark["color7"],
        border_on_single=2,
        margin=10,
        margin_on_single=10,
    ),
    Max(
        border_normal=onedark["color16"],
        border_focus=onedark["color5"],
        border_width=0,
        margin=0,
    ),
    MonadTall(
        border_normal=onedark["color16"],
        border_focus=onedark["color5"],
        margin=10,
        border_width=2,
        single_border_width=2,
        single_margin=10,
    ),
    Stack(
        border_normal=onedark["color16"],
        border_focus=onedark["color5"],
        border_width=2,
        num_stacks=1,
        margin=10,
    ),
]

widget_defaults = dict(
    font="JetBrains Mono Nerd Font",
    fontsize=15,
    padding=10,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(top=bar),
]

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                "term",
                terminal,
                width=0.4,
                height=0.5,
                x=0.3,
                y=0.1,
                opacity=0.8,
            ),
            DropDown(
                "ncmpcpp",
                f"{terminal} -e ncmpcpp",
                width=0.5,
                height=0.5,
                x=0.25,
                y=0.1,
                opacity=0.8,
                on_focus_lost_hide=False,
            ),
            DropDown(
                "mc",
                f"{terminal} -e mc",
                width=0.5,
                height=0.5,
                x=0.25,
                y=0.1,
                opacity=0.8,
            ),
            DropDown(
                "botttom",
                f"{terminal} -e btm",
                width=0.6,
                height=0.6,
                x=0.2,
                y=0.1,
                opacity=0.8,
            ),
        ],
    )
)

# extend keys list with keybinding for scratchpad
keys.extend(
    [
        Key(
            [mod, "mod1"],
            "1",
            lazy.group["scratchpad"].dropdown_toggle("term"),
        ),
        Key(
            [mod, "mod1"],
            "2",
            lazy.group["scratchpad"].dropdown_toggle("ncmpcpp"),
        ),
        Key(
            [mod, "mod1"],
            "3",
            lazy.group["scratchpad"].dropdown_toggle("botttom"),
        ),
    ]
)

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = Floating(
    float_rules=[
        *Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
        Match(wm_class="Pinentry-gtk-2"),
    ],
    border_focus=onedark["color5"],
    border_normal=onedark["color16"],
    border_width=2,
)
auto_fullscreen = True
focus_on_window_activation = "focus"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "LG3D"

@hook.subscribe.startup
def startup():
    bar.show(False)
