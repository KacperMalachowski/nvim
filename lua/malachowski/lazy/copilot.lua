return {
    "github/copilot.vim",
    init = function ()
        vim.g.copilot_no_tab_map = true

        vim.keymap.set('i', '<C-l>', function ()
            return vim.fn['copilot#Accept']('')
        end, {
            expr = true,
            replace_keycodes = false,
            silent = true,
        })

        vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)')
        vim.keymap.set('i', '<M-[>', '<Plug>(copilot-prev)')

        vim.keymap.set('i', '<M-e>', '<Plug>(copilot-dismiss)')
    end
}
