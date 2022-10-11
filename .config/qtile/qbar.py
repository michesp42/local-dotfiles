import os

from libqtile.lazy import lazy
from libqtile.bar import Bar
from libqtile.widget.sep import Sep
from libqtile.widget.textbox import TextBox
from libqtile.widget.clock import Clock
from libqtile.widget.cpu import CPU
from libqtile.widget import ThermalSensor
from libqtile.widget.volume import Volume
from libqtile.widget.battery import Battery
from libqtile.widget import CurrentLayoutIcon
from libqtile.widget.currentlayout import CurrentLayout
from libqtile.widget.groupbox import GroupBox
from libqtile.widget.memory import Memory
from libqtile.widget.net import Net
from libqtile.widget.quick_exit import QuickExit
from libqtile.widget.systray import Systray
from libqtile.widget.window_count import WindowCount
from libqtile.widget.windowname import WindowName

from qcolors import onedark

bar_edge_separator = Sep(
    linewidth=2,
    padding=2,
    foreground=onedark["color9"],
    background=onedark["color9"],
)
invisible_separator = Sep(
    linewidth=2,
    padding=4,
    foreground=onedark["colorback"],
    background=onedark["colorback"],
)

# Remove portions of windows group_names
def parse_func(text):
    for string in ["LibreWolf", "Emacs", "pdf", "djvu", "epub", "mpv", "~"]:
        if string in text:
            if string == "~":
                text = "Terminal"
            else:
                text = string
    return text


bar = Bar(
    [
        bar_edge_separator,
        TextBox(
            text="  ",
            padding=1,
            fontsize=20,
            foreground=onedark["color5"],
            background=onedark["colorback"],
            mouse_callbacks={"Button1": lazy.spawn("rofi-clickmenu")},
        ),
        TextBox(
            text="",
            padding=2,
            foreground=onedark["color4"],
            background=onedark["colorback"],
        ),
        GroupBox(
            font="Font Awesome 6 Free Solid",
            fontsize=12,
            padding=3,
            fmt="{}",
            borderwidth=2,
            background=onedark["colorback"],
            active=onedark["color5"],
            inactive=onedark["color16"],
            rounded=False,
            block_highlight_text_color=onedark["color6"],
            highlight_method="line",
            highlight_color=onedark["colorback"],  #  line block colour
            # use `colorback` for this_curren...border to not show line/block
            this_current_screen_border=onedark["colorback"],
            this_screen_border=onedark["color7"],
            urgent_alert_method="line",
            urgent_border=onedark["color10"],
            urgent_text=onedark["color14"],
            disable_drag=True,
        ),
        TextBox(
            text="",
            padding=2,
            foreground=onedark["color4"],
            background=onedark["colorback"],
        ),
        CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=onedark["color14"],
            background=onedark["colorback"],
            padding=0,
            scale=0.7,
        ),
        CurrentLayout(
            foreground=onedark["color14"],
            background=onedark["colorback"],
            padding=5,
        ),
        invisible_separator,
        TextBox(
            text="",
            font="Font Awesome 6 Free Solid",
            fontsize=15,
            background=onedark["colorback"],
            foreground=onedark["color4"],
            padding=2,
        ),
        WindowCount(
            format=" {num} ",
            background=onedark["colorback"],
            foreground=onedark["color4"],
            show_zero=True,
        ),
        invisible_separator,
        TextBox(
            text="",
            font="Font Awesome 6 Free Solid",
            fontsize=15,
            padding=2,
            foreground=onedark["color2"],
            background=onedark["colorback"],
        ),
        WindowName(
            foreground=onedark["color5"],
            background=onedark["colorback"],
            padding=5,
            format="{name}",
            empty_group_string="[ ]",
            parse_text=parse_func,
        ),
        invisible_separator,
        TextBox(
            text="",
            font="Font Awesome 6 Free Solid",
            fontsize=15,
            padding=2,
            background=onedark["colorback"],
            foreground=onedark["color15"],
        ),
        Net(
            interface="wlp0s20f3",
            format="{down} {up}",
            prefix="M",
            foreground=onedark["color15"],
            background=onedark["colorback"],
            padding=5,
        ),
        invisible_separator,
        TextBox(
            text="",
            font="Font Awesome 6 Free Solid",
            fontsize=15,
            padding=2,
            foreground=onedark["color3"],
            background=onedark["colorback"],
        ),
        CPU(
            background=onedark["colorback"],
            foreground=onedark["color3"],
            fmt="Cpu: {}",
            # format = '{freq_current}GHz {load_percent}%',
            format="{load_percent}%",
            padding=5,
        ),
        invisible_separator,
        TextBox(
            text="",
            font="Font Awesome 6 Free Solid",
            fontsize=15,
            padding=2,
            foreground=onedark["color10"],
            background=onedark["colorback"],
        ),
        ThermalSensor(
            foreground=onedark["color10"],
            background=onedark["colorback"],
            threshold=90,
            fmt="Temp: {}",
            format="{temp:.0f}{unit}",
            padding=5,
        ),
        invisible_separator,
        TextBox(
            text="",
            font="Font Awesome 6 Free Solid",
            fontsize=15,
            padding=2,
            foreground=onedark["color5"],
            background=onedark["colorback"],
        ),
        Memory(
            foreground=onedark["color5"],
            background=onedark["colorback"],
            # mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')},
            fmt="Mem: {}",
            # format = '{MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}',
            format="{MemUsed:.0f}{mm}",
            padding=5,
        ),
        invisible_separator,
        TextBox(
            text="",
            font="Font Awesome 6 Free Solid",
            fontsize=15,
            padding=2,
            foreground=onedark["color6"],
            background=onedark["colorback"],
        ),
        Battery(
            padding=5,
            background=onedark["colorback"],
            foreground=onedark["color6"],
            charge_char="AC",
            discharge_char="",
            empty_char="ﮣ",
            full_char="ﭹ",
            fmt="Bat: {}",
            format="{char} {percent:2.0%}",  # {hour:d}:{min:02d} {watt:.2f} W'
            low_percentage=0.20,
            notify_below=21,
            notification_timeout=0,
            low_background="#ff0000",
            low_foreground="#000000",
            update_interval=60,
        ),
        invisible_separator,
        TextBox(
            text="",
            font="Font Awesome 6 Free Solid",
            fontsize=15,
            padding=2,
            foreground=onedark["color7"],
            background=onedark["colorback"],
        ),
        Volume(
            background=onedark["colorback"],
            foreground=onedark["color7"],
            channel="PCM",
            fmt="{:>3}",
        ),
        invisible_separator,
        TextBox(
            text="",
            font="Font Awesome 6 Free Solid",
            fontsize=15,
            padding=2,
            foreground=onedark["color4"],
            background=onedark["colorback"],
        ),
        Clock(
            foreground=onedark["color4"],
            background=onedark["colorback"],
            format="%a %d, %b %I:%M%P",
            padding=5,
        ),
        Systray(
            background=onedark["colorback"],
            icons_size=40,
        ),
        invisible_separator,
        QuickExit(
            default_text="",
            padding=10,
            mouse_callbacks={
                "Button1": lazy.spawn("rofi-powermenu"),
            },
            background=onedark["colorback"],
        ),
        bar_edge_separator,
    ],
    size=25,
    margin=[5, 5, 0, 5],  # border_width=[2, 2, 2, 2], border_color="#00000000"
)
