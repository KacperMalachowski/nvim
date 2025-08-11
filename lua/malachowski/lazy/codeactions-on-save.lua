return {
    {
        "fnune/codeactions-on-save.nvim",
        config = function()
            local cos = require("codeactions-on-save")
            cos.register({ "*.py" }, { "source.organizeImports" })
            cos.register({ "*.ts", "*.tsx", "*.js", "*.jsx" }, { "source.organizeImports.biome", "source.fixAll" })
            cos.register({ "*.lua" }, { "source.organizeImports" })
            cos.register({ "*.go" }, { "source.organizeImports" })
        end
    }
}
