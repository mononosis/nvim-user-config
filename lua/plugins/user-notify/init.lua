local M = {}
local notify = require("notify")
function M.setup()
  notify.setup({
    background_colour = "NotifyBackground",
    top_down = true,
    stages = "static",
    render = "default"
  })
end
function M.send(message, level)
  notify(message, level)
end
return M
