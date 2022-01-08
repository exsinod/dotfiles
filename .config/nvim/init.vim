set nocompatible              " be iMproved, required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle For Managing Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

	"{{ The Basics }}
      Plug 'morhetz/gruvbox'
      Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
	    Plug 'neoclide/coc.nvim', {'branch': 'release'}
	    Plug 'itchyny/lightline.vim'                       " Lightline statusbar
	"{{ File management }}
	    Plug 'scrooloose/nerdtree'                         " Nerdtree
        Plug 'Xuyuanp/nerdtree-git-plugin'
	    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'     " Highlighting Nerdtree
	    Plug 'ryanoasis/vim-devicons'                      " Icons for Nerdtree
	"{{ Tim Pope Plugins }}
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-fugitive'
	"{{ Syntax Highlighting and Colors }}
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        Plug 'junegunn/goyo.vim'
        Plug 'chrisbra/Colorizer'
        Plug 'airblade/vim-gitgutter'
        Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    "{{ Javascript and typescript }}
        Plug 'yuezk/vim-js'
        Plug 'maxmellon/vim-jsx-pretty'
        Plug 'HerringtonDarkholme/yats.vim'
    " {{ Telescope }}
        Plug 'nvim-lua/popup.nvim'
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'
    " {{ Presenting }}
        Plug 'Chaitanyabsprip/present.nvim'

call plug#end()
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

" Set true colors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Correcting FZF goodness
"
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path '**/bower_components/**' -prune -o -path '**/node_modules/**' -prune -o -path 'target/**' -prune -o -path 'build/**' -prune -o -path 'dist/**' -prune -o -path '**.class' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(160)
  let width = float2nr(260)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme gruvbox
set background=dark
set path+=**                            " Searches current directory recursively.
set wildmenu                            " Display all matches when tab complete.
set incsearch                           " Incremental search
set hidden                              " Needed to keep multiple buffers open
set nobackup                            " No auto backups
set noswapfile                          " No swap
set nowrap
set t_Co=256                            " Set if term supports 256 colors.
set number relativenumber               " Display line numbers
set clipboard=unnamedplus               " Copy/paste between vim and other programs.
syntax enable
let g:rehash256 = 1

set undofile                            "turn on the feature  
set undodir=$XDG_CACHE_HOME/vim/undo    "directory where the undo files will be stored

" default updatetime 4000ms is not good for async update
set updatetime=100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The lightline.vim theme
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }

" Always show statusline
set laststatus=2

" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                   " Use spaces instead of tabs.
set smarttab                    " Be smart using tabs ;)
set shiftwidth=2                " One tab == four spaces.
set tabstop=2                   " One tab == four spaces.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Uncomment to autostart the NERDTree
" autocmd vimenter * NERDTree
map <Leader>n :NERDTreeFind<CR>
let g:NERDTreeChDirMode = 2     " So that NERDTree changes CWD needed for fzf
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=60

let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusShowIgnored = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>g :GFiles<CR>
map <leader>v :Ag<CR>
nnoremap <silent> <C-p> :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>
nnoremap <silent> <leader>b :Buffers<CR>

autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
function SetVimPresentationMode()
    setf markdown
    nnoremap <buffer> <Right> :bnext<CR>
    nnoremap <buffer> <Left> :bprevious<CR>
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mouse Scrolling
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Splits and Tabbed Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow splitright

" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap gq :tabclose<CR>

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" Additional config
source ~/.config/nvim/coc.vim
