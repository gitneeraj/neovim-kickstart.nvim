return {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  config = function()
    vim.keymap.set('n', '<leader>k', ':Lspsaga hover_doc<CR>')
    vim.keymap.set('n', '<leader>gs', ':Lspsaga signature_help<CR>')
    vim.keymap.set('n', '<leader>rn', ':Lspsaga rename<CR>')
    vim.keymap.set('n', '<leader>ca', ':Lspsaga code_action<CR>')
    vim.keymap.set('n', '<leader>gl', ':Lspsaga show_line_diagnostics<CR>')
    vim.keymap.set('n', '<leader>gn', ':Lspsaga diagnostic_jump_next<CR>')
    vim.keymap.set('n', '<leader>gp', ':Lspsaga diagnostic_jump_prev<CR>')
    require("lspsaga").setup({
      ui = {
        border = "rounded",
        code_action = "💡",
        colors = {
          normal_bg = "NONE",
        },
      },
      hover = {
        max_width = 0.6,
        max_height = 0.8,
        open_link = "gx",
      },
      symbol_in_winbar = {
        enable = false,
      },
    })
    -- Fix lspsaga highlight groups to use onenord colors
    vim.api.nvim_set_hl(0, "SagaBorder",    { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "SagaNormal",    { link = "NormalFloat" })
    vim.api.nvim_set_hl(0, "SagaTitle",     { link = "Title" })
    vim.api.nvim_set_hl(0, "SagaBeacon",    { link = "Visual" })
  end,
  dependencies = {
    {"nvim-tree/nvim-web-devicons"},
    -- Please make sure you install markdown and markdown_inline parser
    {"nvim-treesitter/nvim-treesitter"}
  }
}
