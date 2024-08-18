local M = {}
function M.setup()
  local ls = require 'luasnip'
  local s = ls.snippet
  local t = ls.text_node
  local i = ls.insert_node

  ls.add_snippets("html", {
    s("html", {
      t({
        "<!DOCTYPE html>",
        "<html lang=\"en\">",
        "<head>",
        "    <meta charset=\"UTF-8\">",
        "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
        "    <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">",
        "    <title>"
      }),
      i(1, "Document"),
      t({ "</title>",
        "</head>",
        "<body>", "    "
      }),
      i(2),
      t({
        "",
        "</body>",
        "</html>"
      }),
    })
  })

end
return M

