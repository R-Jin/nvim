local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons" -- Icons for nvim-tree
  use "kyazdani42/nvim-tree.lua" -- File explorer tree
  use "akinsho/bufferline.nvim" -- Show bufferline
  use "moll/vim-bbye"
  use "akinsho/toggleterm.nvim" -- Terminal inside nvim
  use "vimwiki/vimwiki"         -- Vimwiki

  -- Colorschemes
  use 'folke/tokyonight.nvim'

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- Buffer completions
  use "hrsh7th/cmp-path" -- Path completions
  use "hrsh7th/cmp-cmdline" -- Cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- Snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- LSP completions
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" -- Snippet engine
  use "rafamadriz/friendly-snippets" -- A bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- Enable LSP
  use "williamboman/nvim-lsp-installer" -- Simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- For formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow" -- Rainbow params

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Lualine
  use "nvim-lualine/lualine.nvim"

  -- Tmux Navigator
  use {
        'christoomey/vim-tmux-navigator',
        config = function()
          vim.g.tmux_navigator_no_mappings = 1

          vim.api.nvim_set_keymap('n', '<c-h>', ':TmuxNavigateLeft<CR>',  {noremap = true, silent = true})
          vim.api.nvim_set_keymap('n', '<c-j>', ':TmuxNavigateDown<CR>',  {noremap = true, silent = true})
          vim.api.nvim_set_keymap('n', '<c-k>', ':TmuxNavigateUp<CR>',    {noremap = true, silent = true})
          vim.api.nvim_set_keymap('n', '<c-l>', ':TmuxNavigateRight<CR>', {noremap = true, silent = true})
        end
      }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
