-- Rex server config: keybindings, key modes and custom actions.
-- App settings (font, theme) live in the app's preferences, not here.
-- Docs: https://www.superlogical.com/rex/docs/customize/config
-- Apply changes with `rex config reload`.

-- Keybindings ported from tmux, with ctrl+a as the prefix
local prefix = "ctrl+a>"

local function bind(key, action, args)
  rex.bind(prefix .. key, action, args)
end

-- Press the prefix twice to send ctrl+a to the terminal
bind("ctrl+a", "pane.send_key", { key = "ctrl+a" })

-- Tabs (tmux windows)
bind("c", "client.tab.new")
bind("n", "client.tab.next")
bind("p", "client.tab.previous")
bind(",", "client.tab.rename")
bind("shift+7", "client.tab.close") -- &
for i = 1, 9 do
  bind(tostring(i), "client.tab.goto", { index = i })
end

bind("ctrl+h", "client.tab.previous")
bind("ctrl+l", "client.tab.next")

-- Panes
bind("shift+5", "pane.split.right") -- %
bind("shift+'", "pane.split.down") -- "
bind("h", "pane.focus.left")
bind("j", "pane.focus.down")
bind("k", "pane.focus.up")
bind("l", "pane.focus.right")
bind("o", "pane.focus_next")
bind("z", "pane.zoom")
bind("f", "pane.float")

-- Floating panes
bind("m", "pane.minimize_floating")
bind("shift+m", "pane.minimize_all_floating") -- M

-- Like tmux's kill-pane: closes the pane, then the tab, then the session
bind("x", "client.close")
bind("shift+1", "pane.move_to_new_tab") -- !

-- Resize without the prefix, like tmux's bind -n M-H
rex.bind("alt+shift+h", "pane.resize", { direction = "left" })
rex.bind("alt+shift+j", "pane.resize", { direction = "down" })
rex.bind("alt+shift+k", "pane.resize", { direction = "up" })
rex.bind("alt+shift+l", "pane.resize", { direction = "right" })

-- Sessions
bind("s", "session.switch")
bind("shift+c", "session.new") -- C
bind("shift+4", "session.rename") -- $
bind("shift+9", "session.previous") -- (
bind("shift+0", "session.next") -- )
bind("shift+x", "session.close") -- X, like tmux's kill-session

bind("shift+;", "client.palette.toggle") -- :, like tmux's command prompt
bind("[", "client.find.open")
bind("shift+r", "client.config.reload")
