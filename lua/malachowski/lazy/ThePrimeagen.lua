return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()

            vim.keymap.set("n", "<leader>A", function()
				harpoon:list():prepend()
			end)
			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<C-h>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-t>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-s>", function()
				harpoon:list():select(4)
			end)
			vim.keymap.set("n", "<leader><C-h>", function()
				harpoon:list():replace_at(1)
			end)
			vim.keymap.set("n", "<leader><C-t>", function()
				harpoon:list():replace_at(2)
			end)
			vim.keymap.set("n", "<leader><C-n>", function()
				harpoon:list():replace_at(3)
			end)
			vim.keymap.set("n", "<leader><C-s>", function()
				harpoon:list():replace_at(4)
			end)
        end,
    },
    {
        "ThePrimeagen/99",
        config = function()
            local _99 = require("99")
            local Providers = require("99.providers")

            _99.setup({
                provider = Providers.ClaudeCodeProvider,
                model = "claude-sonnet-4-6",
                md_files = {
                    "AGENTS.md",
                    "CLAUDE.md"
                },
                completion = {
                    custom_rules = {
                        "~/.claude/skills",
                        "~/.agents/skills",
                        ".claude/skills",
                        ".agents/skills"
                    },
                    source = "cmp"
                },
            })

            -- Workaround: Override read_tmp prompt to allow reading temp file
            local prompt_settings = require("99.prompt-settings")
            prompt_settings.prompts.read_tmp = function()
                return [[
TEMP_FILE is purely for output.
If your tool requires reading before writing, read TEMP_FILE first (it may be empty), then write your results.
After writing TEMP_FILE once, DO NOT perform any other actions. DO NOT read the file again. DO NOT communicate with the user. Immediately end the session.
]]
            end

            vim.keymap.set("n", "<leader>9v", function ()
                _99.vibe()
            end)
            vim.keymap.set("v", "<leader>9v", function ()
                _99.visual()
            end)
            vim.keymap.set("n", "<leader>9s", function ()
                _99.search()
            end)
            vim.keymap.set("n", "<leader>9o", function ()
                _99.open()
            end)
            vim.keymap.set("n", "<leader>9x", function ()
                _99.stop_all_requests()
            end)
            vim.keymap.set("n", "<leader>9i", function ()
                _99.info()
            end)
            vim.keymap.set("n", "<leader>9l", function ()
                _99.view_logs()
            end)
            vim.keymap.set("n", "<leader>9n", function ()
                _99.next_request_logs()
            end)
            vim.keymap.set("n", "<leader>9p", function ()
                _99.prev_request_logs()
            end)
        end
    }
}

