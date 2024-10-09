-- WezTerm configuration
---------------------------------------------------------------
local wezterm = require 'wezterm'

local act = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = 'kanagawabones'
config.font_size = 16
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.8
config.window_decorations = 'RESIZE'
config.native_macos_fullscreen_mode = true
-- if mouse is used... we finna move away from this s00n
config.pane_focus_follows_mouse = true
-- https://wezfurlong.org/wezterm/config/lua/gui-events/gui-startup.html

config.keys = {
    -- Show tab navigator
    {
        key = 'p',
        mods = 'CMD',
        action = wezterm.action.ShowTabNavigator
    },
    -- Show launcher menu
    {
        key = 'P',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ShowLauncher
    },
    -- Vertical pipe (|) -> horizontal split
    {
        key = 'v',
        mods = 'CMD|SHIFT',
        action = wezterm.action.SplitHorizontal {
            domain = 'CurrentPaneDomain'
        },
    },
    -- Underscore (_) -> vertical split
    {
        key = 'h',
        mods = 'CMD|SHIFT',
        action = wezterm.action.SplitVertical {
            domain = 'CurrentPaneDomain'
        },
    },
    -- Rename current tab
    {
        key = 'E',
        mods = 'CMD|SHIFT',
        action = wezterm.action.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(
                function(window, _, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end
            ),
        },
    },
    -- Move to a pane (prompt to which one)
    {
        mods = "CMD",
        key = "m",
        action = wezterm.action.PaneSelect
    },
    -- Move to another pane (next or previous)
    {
        key = "[",
        mods = "CMD",
        action = wezterm.action.ActivatePaneDirection('Prev')
    },
    {
        key = "]",
        mods = "CMD",
        action = wezterm.action.ActivatePaneDirection('Next')
    },
    -- Move to another tab (next or previous)
    {
        key = "{",
        mods = "CMD|SHIFT",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        key = "}",
        mods = "CMD|SHIFT",
        action = wezterm.action.ActivateTabRelative(1)
    },
    -- Use CMD+Shift+S t swap the active pane and another one
    {
        key = "s",
        mods = "CMD|SHIFT",
        action = wezterm.action {
            PaneSelect = { mode = "SwapWithActiveKeepFocus" }
        }
    },
    -- Use CMD+w to close the pane, CMD+SHIFT+w to close the tab
    {
        key = "w",
        mods = "CMD",
        action = wezterm.action.CloseCurrentPane { confirm = true }
    },
    {
        key = "w",
        mods = "CMD|SHIFT",
        action = wezterm.action.CloseCurrentTab { confirm = true }
    },
    -- Use CMD+z to enter zoom state
    {
        key = 'z',
        mods = 'CMD',
        action = wezterm.action.TogglePaneZoomState,
    },
    -- Launch commands in a new pane
    {
        key = 'g',
        mods = 'CMD',
        action = wezterm.action.SplitHorizontal {
            args = { os.getenv 'SHELL', '-c', 'lazygit' },
        }
    }
}

local mux = wezterm.mux
wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

return config
