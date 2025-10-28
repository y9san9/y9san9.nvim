require("core")
require("args")

if vim.g.neovide then
    require("neovide")
end

-- Almost builtin
require("plugins.nvim-treesitter")

-- My own theme
require("plugins.themes")

-- Just tracker
require("plugins.wakatime")

-- Can't get rid of oil until we have a builtin file manager:
-- https://github.com/neovim/neovim/discussions/36324
require("plugins.oil")

-- I want to get rid of this at some point of time
-- require("plugins.harpoon")
-- require("plugins.fugitive")
-- require("plugins.telescope")
