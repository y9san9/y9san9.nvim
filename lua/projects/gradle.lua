-- Gradle Project Setup
local M = {}

-- TODO: migrate from global to tab-local commands
-- TODO: implement detach command that will be used to reload project
M.setup = function(options)
    vim.cmd.tcd(options.path)

    terminal(options)
    compile(options)
    cmd(options)
    autostop()

    if options.ktlint then
        ktlint(options)
    end

    vim.cmd.Oil()
end

function autostop()
    vim.api.nvim_create_autocmd({'VimLeavePre'}, {
        callback = function()
            vim.cmd("!./gradlew --stop")
        end
    })
end

function terminal(options)
    local terminal = options.terminal or {}
    local command = terminal.command or "./gradlew build -q -t"

    vim.cmd.terminal()
    vim.fn.feedkeys("i")
    vim.fn.feedkeys(command)
    vim.fn.feedkeys("\n")
    vim.fn.feedkeys("")
    vim.fn.feedkeys("G")
    require("harpoon"):list():clear()
    require("harpoon"):list():add()
    vim.fn.feedkeys("", "x!")
end

function compile(options)
    local compile = options.compile
    if not vim.islist(compile) then
        compile = { compile or {} }
    end

    for _, compile_config in ipairs(compile) do
        local command = compile_config.command or
            "./gradlew assemble -q --console=plain"

        local name = compile_config.name or
            "Compile"

        vim.api.nvim_create_user_command(name, function()
            local kotlin = "%t: file://%f:%l:%c %m"
            local ignoreUnknown = "%-G%.%#"
            vim.opt.makeprg = command
            vim.opt.errorformat = {
                kotlin,
                ignoreUnknown,
            }
            vim.cmd.make()
        end, {})
    end
end

function cmd(options)
    local cmd = options.cmd
    if cmd == nil then
        return
    end
    for _, command in ipairs(cmd) do
        vim.api.nvim_create_user_command(command.name, function()
            vim.cmd(command.command)
        end, {})
    end
end

function ktlint(options)
    compile {
        compile = {
            name = "Format",
            command = "./gradlew ktlintFormat -q --console=plain",
        },
    }
end

return M
