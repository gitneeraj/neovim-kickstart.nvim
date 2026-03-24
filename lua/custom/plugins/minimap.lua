return {
  'nvim-mini/mini.nvim',
  config = function()
    local minimap = require('mini.map')
    minimap.setup({
      integrations = {
        minimap.gen_integration.diagnostic({
          error = 'DiagnosticFloatingError',
          warn  = 'DiagnosticFloatingWarn',
          info  = 'DiagnosticFloatingInfo',
          hint  = 'DiagnosticFloatingHint',
        }),
        minimap.gen_integration.builtin_search(),
        minimap.gen_integration.gitsigns(),
      },
      symbols = {
        encode = minimap.gen_encode_symbols.dot('4x2'),
        scroll_line = '█',
        scroll_view = '┃',
      },
      window = {
        focusable = false,
        side = 'right',
        show_integration_count = true,
        width = 10,
        winblend = 25,
      },
    })

    -- Auto-open minimap for normal file buffers
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      callback = function()
        local ft = vim.bo.filetype
        local excluded = { 'NvimTree', 'lazy', 'mason', 'TelescopePrompt', 'lspsaga', 'copilot-chat', '' }
        for _, f in ipairs(excluded) do
          if ft == f then return end
        end
        minimap.open()
      end,
    })

    -- Hide minimap when CopilotChat opens, restore when it closes
    vim.api.nvim_create_autocmd('BufWinEnter', {
      callback = function()
        if vim.bo.filetype == 'copilot-chat' then
          minimap.close()
        end
      end,
    })
    vim.api.nvim_create_autocmd('BufWinLeave', {
      callback = function()
        if vim.bo.filetype == 'copilot-chat' then
          -- small defer so the window is fully gone before reopening
          vim.defer_fn(function() minimap.open() end, 50)
        end
      end,
    })

    vim.keymap.set('n', '<leader>mm', minimap.toggle,       { desc = 'Minimap Toggle' })
    vim.keymap.set('n', '<leader>mf', minimap.toggle_focus, { desc = 'Minimap Focus' })
    vim.keymap.set('n', '<leader>mr', minimap.refresh,      { desc = 'Minimap Refresh' })
  end,
}
