from typing import List  # noqa: F401
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen,  ScratchPad, DropDown
from libqtile.lazy import lazy

mod = "mod1"
terminal = 'alacritty'

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    #Key([mod], "space", lazy.layout.next(),
    #    desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "control"], "h", lazy.layout.swap_column_left(),
        desc="Move window to the left"),
    Key([mod, "control"], "l", lazy.layout.swap_column_right(),
        desc="Move window to the right"),
    Key([mod, "control"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "control"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "mod4"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "mod4"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "mod4"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "mod4"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "mod4"], "b", lazy.layout.shrink()),
    Key([mod, "mod4"], "m", lazy.layout.maximize(),
        desc="maximize window"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "control"], "space", lazy.layout.flip()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "c", lazy.spawn("chromium"), desc="Launch Chromium"),
    Key([mod], "f", lazy.spawn("firefox"), desc="Launch Firefox"),
    Key([mod], "q", lazy.spawn("dolphin"), desc="Launch Dolphin"),
    Key([mod], 'space', lazy.spawn('rofi -show drun')),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
    
    # Hardware Keys
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl -s set +5")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl -s set 5-")),
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer set Master 5%+ unmut")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer set Master 5%- unmut")
    ),
    Key(
        [], "XF86AudioMute",
        lazy.spawn("amixer set Master toggle")
    ),
]

groups = [
   Group('a', layout='columns'),
    Group('s', layout='monadtall'),
    Group('e', layout='max'),
    Group('x', layout='columns'), 
]

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),
        #switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

groups.append(
    ScratchPad('scratchpad', [
        DropDown('term','alacritty',width=0.44, height=0.4, x=0.28, y=0.2),
        DropDown('term2','alacritty',width=0.44, height=0.35, x=0.28, y=0.2),
    ]),
)

keys.extend([
    Key(["control"], "1", lazy.group['scratchpad'].dropdown_toggle('term')),
    Key(["control"], "2", lazy.group['scratchpad'].dropdown_toggle('term2')),
])

layouts = [
    layout.Columns(margin=6, border_focus='#37474F', border_normal='#111111'),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(border_focus='#222222', margin=6, ratio=0.65, max_ratio=0.65, min_secondary_size=140),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = []

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),
    Match(title='Bluetooth')# GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
