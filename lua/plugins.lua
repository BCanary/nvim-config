vim.cmd [[packadd packer.nvim]]
--vim.lsp.set_log_level("debug")
return require('packer').startup(function(use)
  --  use 'OmniSharp/omnisharp-vim'
  use {'nvim-treesitter/nvim-treesitter',run=":TSUpdate"}
  -- Автоустановка пакетного менеджера
  use 'wbthomason/packer.nvim'
  ---------------------------------------------------------
  -- ПЛАГИНЫ ВНЕШНЕГО ВИДА
  ---------------------------------------------------------
  -- Информационная строка внизу
  use "kyazdani42/nvim-web-devicons"
  use { 'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      config = function()
      require('lualine').setup()
  end, }
  -- Тема в стиле Rose Pine
  -- use({
  --  'gruvbox',
  --  as = 'rose-pine',
   -- config = function()
   --   vim.cmd('colorscheme rose-pine')
   -- end
  --})
  use ({'morhetz/gruvbox', as="gruvbox", 
    config=function()
      vim.cmd('colorscheme gruvbox')
    end
  })
  vim.cmd("colorscheme gruvbox")
      
  --vim.cmd('au BufNewFile,BufRead *.xaml set filetype=xml.csharp')
  ---------------------------------------------------------
  -- МОДУЛИ РЕДАКТОРА
  ---------------------------------------------------------
  -- Табы с вкладками сверху
  use {'akinsho/bufferline.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
      require("bufferline").setup{}
  end, }
  -- Структура классов и функций в файле
  use 'majutsushi/tagbar'
  -- use 'ap/vim-css-color'
  -- Файловый менеджер
  use { 'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() 
      require'nvim-tree'.setup {
        git = {
          enable = false
        }
      }
  end, }
  --- popup окошки
  use 'nvim-lua/popup.nvim'
  ---------------------------------------------------------
  -- ПОИСК
  ---------------------------------------------------------
  -- Наш FuzzySearch
    use { 'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} },
      config = function() 
      require'telescope'.setup {}
  end, }
    
  ---------------------------------------------------------
  -- КОД
  ---------------------------------------------------------
  -- автоматические закрывающиеся скобки
  -- vim.configurations 
--  use { 'windwp/nvim-autopairs',
 --     config = function()
  --    require("nvim-autopairs").setup()
  --nd}
  -- Комментирует по <gc> все, вне зависимости от языка программирования
  use { 'numToStr/Comment.nvim',
      config = function() 
      require('Comment').setup() 
  end }
  
  use 'mattn/emmet-vim'
 
  
  ---------------------------------------------------------
  -- LSP И АВТОДОПОЛНЯЛКИ
  ---------------------------------------------------------
  -- Collection of configurations for built-in LSP client
  use 'neovim/nvim-lspconfig'
--  use 'williamboman/nvim-lsp-installer'
use {
    "williamboman/mason.nvim",
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
}
use "williamboman/mason-lspconfig.nvim"
  -- Автодополнялка
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'saadparwaiz1/cmp_luasnip'

  --- Автодополнлялка к файловой системе
  use 'hrsh7th/cmp-path'

  -- Snippets plugin
  use 'L3MON4D3/LuaSnip'
  -- Highlight, edit, and navigate code using a fast incremental parsing library

  -- Линтер, работает для всех языков
  use 'dense-analysis/ale'
  ---------------------------------------------------------
  -- РАЗНОЕ
  ---------------------------------------------------------
  -- Даже если включена русская раскладка, то nvim-команды будут работать
  use 'powerman/vim-plugin-ruscmd'
  use 'xiyaowong/transparent.nvim'
  --use 'hrsh7th/nvim-cmp'
--  use 'hrsh7th/cmp-nvim-lsp'
-- use 'L3MON4D3/LuaSnip'
 -- use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'
end)
