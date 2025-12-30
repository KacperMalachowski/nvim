return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "gofmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                python = { "black" },
                json = { "prettier" },
                yaml = { "prettier" },
                terraform = { "terraform_fmt" },
            },
        })
    end
}
