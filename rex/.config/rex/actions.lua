-- Custom actions, loaded from init.lua. Bind them there with the other keys.

-- Project picker: fzf over ~/Code in a centered float, opening the choice in a
-- new session. $1 is the app to switch; empty lets rex pick the connected one.
-- Always exits 0, because Rex keeps a pane open after a quick failure.
-- Hides names starting with "-", which rex would read as options, and names
-- with control characters, which could split lines or carry terminal escapes.
local project_picker_script = [==[
root="$HOME/Code"
project=$(
  find -L "$root" -mindepth 1 -maxdepth 1 -type d ! -name '.*' ! -name '-*' ! -name '*[[:cntrl:]]*' -exec basename {} \; |
    sort |
    fzf --reverse --prompt='project> '
) || exit 0

session=$(rex new "$project" -c "$root/$project" --json | jq -er '.session_id') &&
  rex ${1:+-C "$1"} do session.select session_id="$session" && exit 0

printf 'Could not open %s. Press Return to close.' "$project"
read -r _
]==]

rex.action({
  name = "project_picker",
  title = "Open Project…",
  description = "Pick a project from ~/Code and open it in a new session",
  category = "Session",
  run = function(ctx)
    -- From `rex do`, the client is that short-lived command rather than an app
    local from_app = ctx.origin == "key" or ctx.origin == "palette"
    local client = from_app and ctx.client_id or ""
    local _, err = rex.session.new_layer({
      bounds = { 0.2, 0.2, 0.6, 0.6 },
      focus = true,
      layout = rex.layout.block({
        flavor = "com.superlogical.terminal.shell",
        options = {
          command = { "sh", "-c", project_picker_script, "project-picker", client },
        },
      }),
    })
    if err ~= nil then
      error(err, 0)
    end
  end,
})
