return {
    "laytan/cloak.nvim",
    config = function()
        -- Before cloak loads, add autocmd to prevent it from activating on wrong files
        vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
            pattern = "*secret*.tf",
            callback = function()
                local filename = vim.fn.expand("%:t")
                -- If filename does NOT end with secret.tf or secrets.tf, prevent cloak
                if not filename:match("secret%.tf$") and not filename:match("secrets%.tf$") then
                    -- Store a buffer variable to indicate cloak should be disabled
                    vim.b.cloak_should_disable = true
                end
            end,
        })
        
        require("cloak").setup({
            enabled = function()
                -- Check if this buffer should have cloak disabled
                if vim.b.cloak_should_disable then
                    return false
                end
                return true
            end,
            cloak_character = "*",
            highlight_group = "Comment",
            patterns = {
                {
                    file_pattern = {
                        ".env*",
                        "wrangler.toml",
                        ".dev.vars",
                        "*secret.tf",
                        "*secrets.tf",
                        "*secret.yaml",
                        "*secret.yml",
                        "*secrets.yaml",
                        "*secrets.yml",
                        "*secret.json",
                        "*secrets.json",
                    },
                    cloak_pattern = "=.+"
                },
            },
        })
    end
}
