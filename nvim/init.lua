-- Set leader keys as early as possible
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Compatibility function for vim.fs.joinpath
vim.fs.joinpath = vim.fs.joinpath or function(...)
    return table.concat({ ... }, "/")
end

-- Load lazy.nvim plugin manager
require("config.lazy")
require("config.telescope")

-- Set transparent background
local function set_transparent_background()
    local highlights = {
        "Normal",
        "NonText"
    }

    for _, group in ipairs(highlights) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end
end

set_transparent_background()
