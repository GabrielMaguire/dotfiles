-- [[ Simple plugin configurations ]]
return {
  'tpope/vim-fugitive', -- Git integration
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} }, -- "gc" to comment visual regions/lines
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {
    scope = { enabled = false },
  } },
  'christoomey/vim-tmux-navigator', -- Ctrl-{h,j,k,l} navigation between nvim and tmux
}
