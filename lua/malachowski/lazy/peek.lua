return {
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup({
                filetype = { "markdown", "conf" },
                -- The default 'webview' needs a GTK/WebKit window, which
                -- fails silently here; use the default browser instead.
                app = "browser",
            })

            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
}
