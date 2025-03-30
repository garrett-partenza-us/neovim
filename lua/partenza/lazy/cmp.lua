-- ~/.config/nvim/lua/partenza/lazy/cmp.lua
return {
  -- nvim-cmp plugin for autocompletion
  "hrsh7th/nvim-cmp",
  -- LSP source for nvim-cmp
  "hrsh7th/cmp-nvim-lsp",
  -- Buffer source for nvim-cmp
  "hrsh7th/cmp-buffer",
  -- Path source for nvim-cmp
  "hrsh7th/cmp-path",
  -- Cmdline source for nvim-cmp
  "hrsh7th/cmp-cmdline",
  -- Snippet support (vsnip in this case)
  "hrsh7th/vim-vsnip",
  "hrsh7th/cmp-vsnip",
  -- LSP Configuration for Go using gopls
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Set up capabilities properly
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- Set up gopls with capabilities
      require("lspconfig").gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            usePlaceholders = true,
            completeUnimported = true,
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          }
        }
      })
    end,
  },
  -- Configure nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For vsnip users
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
        }),
        experimental = {
          ghost_text = true,
        },
      })
      
      -- Additional setup for command line completion
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
      
      -- Setup for '/' and '?' (search)
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
    end
  }
}
