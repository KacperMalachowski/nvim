local upstream = require("99.providers").OpenCodeProvider
local provider = setmetatable({}, { __index = upstream })
local default_model = "OpenCode default"

-- 99's upstream provider always supplies a hard-coded model. Omit -m to let
-- OpenCode resolve the user's global/project model and provider policies.
function provider._get_default_model()
    return default_model
end

function provider._build_command(_, query, context)
    local command = { "opencode", "run", "--agent", "build" }
    if context.model and context.model ~= default_model then
        vim.list_extend(command, { "--model", context.model })
    end
    vim.list_extend(command, { "--", query })
    return command
end

function provider.fetch_models(callback)
    upstream.fetch_models(function(models, err)
        if models then
            table.insert(models, 1, default_model)
        end
        callback(models, err)
    end)
end

return provider
