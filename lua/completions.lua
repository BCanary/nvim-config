-----------------------------------------------------------
require("mason").setup()
-- НАСТРОЙКИ ПЛАГИНОВ
-----------------------------------------------------------
-- LSP settings
--local lsp_installer = require("nvim-lsp-installer")
--lsp_installer.on_server_ready(function(server)
--    local opts = {}
--    if server.name == "sumenko_lua" then
--        -- only apply these settings for the "sumneko_lua" server
 ------       opts.settings = {
--            Lua = {
--                diagnostics = {
 ----                   -- Get the language server to recognize the 'vim', 'use' global
   --                 globals = {'vim', 'use'},
    --            },
     --           workspace = {
      --              -- Make the server aware of Neovim runtime files
 --                   library = vim.api.nvim_get_runtime_file("", true),
--                },
--                -- Do not send telemetry data containing a randomized but unique identifier
--                telemetry = {
--                    enable = false,
--                },
--            },
--        }
--    end
--    server:setup(opts)
--end)
--*/
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
vim.o.completeopt = 'menuone,noselect'
-- luasnip setup
local luasnip = require('luasnip')
-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer', option = {
            get_bufnrs = function()
                return vim.api.nvim_list_bufs()
            end
        },
    },
},
    mapping = {
['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}), 
--      ['<C-n>'] = cmp.mapping.select_next_item(),
--      ['<C-p>'] = cmp.mapping.select_prev_item(),    
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4)),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete()),
      ['<C-e>'] = cmp.mapping(cmp.mapping.abort()),
      ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = true })), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }
})


--mason_lspconfig.setup_handlers({
--	function(server_name)
--		require("lspconfig")[server_name].setup({
--			capabilities = capabilities,
--			on_attach = on_attach,
			--settings = servers[server_name],
--		})
--	end,
--})

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  }
}

require("lspconfig").pyright.setup {
  capabilities = capabilities,
}
local on_attach = function(client, bufnr)
    -- temporary fix for a roslyn issue in omnisharp
    -- opened issues:
    -- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
    -- https://github.com/neovim/neovim/issues/21391
    if client.name == "omnisharp" then
        client.server_capabilities.semanticTokensProvider = {
          full = vim.empty_dict(),
          legend = {
            tokenModifiers = { "static_symbol" },
            tokenTypes = {
              "comment",
              "excluded_code",
              "identifier",
              "keyword",
              "keyword_control",
              "number",
              "operator",
              "operator_overloaded",
              "preprocessor_keyword",
              "string",
              "whitespace",
              "text",
              "static_symbol",
              "preprocessor_text",
              "punctuation",
              "string_verbatim",
              "string_escape_character",
              "class_name",
              "delegate_name",
              "enum_name",
              "interface_name",
              "module_name",
              "struct_name",
              "type_parameter_name",
              "field_name",
              "enum_member_name",
              "constant_name",
              "local_name",
              "parameter_name",
              "method_name",
              "extension_method_name",
              "property_name",
              "event_name",
              "namespace_name",
              "label_name",
              "xml_doc_comment_attribute_name",
              "xml_doc_comment_attribute_quotes",
              "xml_doc_comment_attribute_value",
              "xml_doc_comment_cdata_section",
              "xml_doc_comment_comment",
              "xml_doc_comment_delimiter",
              "xml_doc_comment_entity_reference",
              "xml_doc_comment_name",
              "xml_doc_comment_processing_instruction",
              "xml_doc_comment_text",
              "xml_literal_attribute_name",
              "xml_literal_attribute_quotes",
              "xml_literal_attribute_value",
              "xml_literal_cdata_section",
              "xml_literal_comment",
              "xml_literal_delimiter",
              "xml_literal_embedded_expression",
              "xml_literal_entity_reference",
              "xml_literal_name",
              "xml_literal_processing_instruction",
              "xml_literal_text",
              "regex_comment",
              "regex_character_class",
              "regex_anchor",
              "regex_quantifier",
              "regex_grouping",
              "regex_alternation",
              "regex_text",
              "regex_self_escaped_character",
              "regex_other_escape",
            },
          },
          range = true,
        }
    end

    -- specifies what to do when language server attaches to the buffer
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end
require("lspconfig").omnisharp.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

