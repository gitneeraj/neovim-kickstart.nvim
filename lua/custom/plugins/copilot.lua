return {
  -- Copilot inline code completion
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,    -- show suggestions automatically as you type
          debounce = 75,
          keymap = {
            accept = "<Tab>",           -- accept full suggestion
            accept_word = "<C-Right>",  -- accept one word at a time
            accept_line = "<C-l>",      -- accept one line at a time
            next = "<M-]>",             -- next suggestion
            prev = "<M-[>",             -- previous suggestion
            dismiss = "<C-e>",          -- dismiss suggestion
          },
        },
        panel = { enabled = false },    -- we use copilot-cmp instead of the panel
        filetypes = {
          ["*"] = true,                 -- enable for all filetypes
        },
      })
    end,
  },

  -- Feed Copilot suggestions into nvim-cmp completion menu
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      model = "claude-sonnet-4",  -- default model (change to gpt-4o, gpt-4.1, o3, etc.)
      window = {
        layout = "vertical",   -- open as a vertical split (like VS Code's side panel)
        width = 0.35,          -- 35% of screen width
      },
      show_help = true,
    },
    keys = {
      -- Toggle chat window
      { "<leader>cc", "<cmd>CopilotChatToggle<CR>",  mode = { "n", "v" }, desc = "Copilot Chat Toggle" },
      -- Pick a model interactively
      {
        "<leader>cm",
        function() require("CopilotChat").select_model() end,
        desc = "Copilot Select Model",
      },
      -- Pick an agent interactively (copilot, claude, etc.)
      {
        "<leader>ca",
        function() require("CopilotChat").select_agent() end,
        desc = "Copilot Select Agent",
      },
      -- Open chat with selected code (visual mode)
      { "<leader>ce", "<cmd>CopilotChatExplain<CR>", mode = "v",          desc = "Copilot Explain" },
      { "<leader>cr", "<cmd>CopilotChatReview<CR>",  mode = "v",          desc = "Copilot Review" },
      { "<leader>cf", "<cmd>CopilotChatFix<CR>",     mode = "v",          desc = "Copilot Fix" },
      { "<leader>ct", "<cmd>CopilotChatTests<CR>",   mode = "v",          desc = "Copilot Generate Tests" },
      -- Ask a question inline
      {
        "<leader>cq",
        function()
          local input = vim.fn.input("Copilot: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "Copilot Quick Ask",
      },
    },
  },
}
