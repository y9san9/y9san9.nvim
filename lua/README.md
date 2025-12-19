# Lua Extensions

These extensions are not a part of my config directly. They are never included
in the [init.lua](../init.lua) file. But why do I need them? That's just how I
manage projects. Before I start my work session on one, I usually source some
lua file that lives inside `.nvim` directory and has all the windows and
terminals to be opened as well as some per-project settings (LSPs and stuff).

Consider I have this `/Programming/python/` project and I may have such
`/Programmin/python/.nvim/init.lua` file:

```lua
local terminal = require('terminal')

vim.cmd.cd('/Programming/python')
terminal.attach {
    command = '...' -- basically enter a python venv
}
vim.cmd.Oil()

vim.lsp.enable('basedpyright')

-- create some project-wide formatting command
vim.api.nvim_create_user_command('F', ...)
```

In order to keep these files as small as possible, I have some scripts prepared
in advance. In the example above I used [terminal.lua](terminal.lua) file to
define `attach` function that will not require as much code as it requires right
now to open a terminal.
