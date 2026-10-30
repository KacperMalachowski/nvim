local upstream = require("99.providers").ClaudeCodeProvider
local provider = setmetatable({}, { __index = upstream })
local default_model = "Claude default"

-- Read-only shell commands. Leave out anything that can write or execute
-- (find -delete/-exec, sed -i, awk system(), xargs, rg --pre, git grep -O);
-- the Grep tool already covers searching.
local read_only_bash = {
    "Bash(git status:*)", "Bash(git log:*)", "Bash(git diff:*)", "Bash(git show:*)",
    "Bash(git blame:*)", "Bash(git ls-files:*)",
    "Bash(ls:*)", "Bash(cat:*)", "Bash(head:*)", "Bash(tail:*)", "Bash(wc:*)", "Bash(pwd)",
}

-- Flags that make the allowed git commands write files or run programs.
local denied_bash = { "Bash(git * --output*)", "Bash(git * --ext-diff*)" }

-- 99's upstream provider passes --dangerously-skip-permissions and pins a dated
-- model. Allow reads plus writes under 99's temp dir only, and omit --model so
-- Claude Code settings pick the model unless one is selected.
function provider._get_default_model()
    return default_model
end

function provider._build_command(_, query, context)
    -- A leading // marks an absolute path in Claude Code permission rules.
    local tmp_dir = vim.fn.fnamemodify(context.tmp_file, ":p:h")
    local command = {
        "claude", "--print",
        "--permission-mode", "dontAsk",
        "--allowedTools", "Read", "Grep", "Glob", "Edit(/" .. tmp_dir .. "/**)",
    }
    vim.list_extend(command, read_only_bash)
    table.insert(command, "--disallowedTools")
    vim.list_extend(command, denied_bash)
    if context.model and context.model ~= default_model then
        vim.list_extend(command, { "--model", context.model })
    end
    vim.list_extend(command, { "--", query })
    return command
end

-- Aliases track the current models, unlike upstream's hard-coded IDs.
function provider.fetch_models(callback)
    callback({ default_model, "opus", "sonnet", "haiku" }, nil)
end

return provider
