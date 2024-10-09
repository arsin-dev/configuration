local M = {}

function M.setup()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')

    telescope.setup({
        defaults = {
            file_ignore_patterns = {
                "node_modules",
                ".git",
            },
            -- Use fd for file discovery
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
            -- Use ripgrep for grep
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob=!.git/",
            },
        },
        pickers = {
            live_grep = {
                theme = "dropdown",
            },
            find_files = {
                theme = "dropdown",
                -- Use fd here as well
                find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
            },
            buffers = {
                theme = "dropdown",
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            file_browser = {
                theme = "dropdown",
                -- disables netrw and use telescope-file-browser in its place
                hijack_netrw = true,
            },
        },
    })


    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    -- Load extensions if you have any
    telescope.load_extension('fzf')
    telescope.load_extension('file_browser')
end

return M
