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
            _99.setup({
                md_files = {
                    "AGENTS.md",
                    "CLAUDE.md"
                },
                completion = {
                    custom_rules = {
                        "~/.config/opencode/skills",
                        "~/.claude/skills",
                        "~/.agents/skills",
                        ".opencode/skills",
                        ".claude/skills",
                        ".agents/skills"
                    },
                    source = "cmp"
                },
            })
            vim.keymap.set("v", "<leader>9vv", function ()
                _99.visual()
            end)
            vim.keymap.set("v", "<leader>9vp", function ()
                _99.visual_prompt()
            end)
            vim.keymap.set("n", "<leader>9s", function ()
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

