return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    ft = {
      'lua',
      'go',
      'bash',
      'sh',
      'css',
      'html',
      'cucumber',
      'dockerfile',
      'yaml.docker-compose',
      'typescript',
      'javascript',
      'vue',
      'rust',
      -- 'python',
      -- 'java',
      -- 'c'
    },
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf })
          end

          map('<leader>cr', vim.lsp.buf.rename)
          map('<leader>ca', vim.lsp.buf.code_action, { 'n', 'x' })
          map('<leader>cj', function()
            vim.diagnostic.jump { count = 1 }
          end)
          map('<leader>ck', function()
            vim.diagnostic.jump { count = -1 }
          end)
          map('<leader>cl', vim.diagnostic.open_float)
          map('gr', require('telescope.builtin').lsp_references)
          map('gi', require('telescope.builtin').lsp_implementations)
          map('gd', require('telescope.builtin').lsp_definitions)
          map('gD', vim.lsp.buf.declaration)
          map('gO', require('telescope.builtin').lsp_document_symbols)
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols)
          map('gt', require('telescope.builtin').lsp_type_definitions)

          local function client_supports_method(client, method, bufnr)
            return client:supports_method(method, bufnr)
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end)
          end

          if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, event.buf) then
            local bufnr = event.buf
            vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
            vim.keymap.set('i', '<C-F>', vim.lsp.inline_completion.get, { desc = 'LSP: accept inline completion', buffer = bufnr })
            vim.keymap.set('i', '<C-G>', vim.lsp.inline_completion.select, { desc = 'LSP: switch inline completion', buffer = bufnr })
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
      local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
      }

      local servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              usePlaceholders = true,
              staticcheck = true,
              gofumpt = true,
            },
          },
        },

        rust_analyzer = {},

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },

        bashls = {},

        cssls = {},

        html = {},

        tailwindcss = {},

        vue_ls = {},

        vtsls = {
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  vue_plugin,
                },
              },
            },
          },
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        },

        dockerls = {},

        docker_compose_language_service = {},

        cucumber_language_server = {},

        copilot = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  {
    'ray-x/go.nvim',
    ft = { 'go', 'gomod' },
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end,
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  {
    ft = { 'java' },
    'nvim-java/nvim-java',
    config = function()
      require('java').setup {
        spring_boot_tools = {
          enable = false,
        },
        vim.lsp.config('jdtls', {
          settings = {
            java = {
              configuration = {
                runtimes = {
                  {
                    name = 'JavaSE-21',
                    path = '/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home/',
                    default = true,
                  },
                },
              },
            },
          },
        }),
      }
      vim.lsp.enable 'jdtls'
    end,
  },
}
