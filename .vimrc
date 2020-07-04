set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'reasonml-editor/vim-reason-plus'
Plug 'unisonweb/unison', {'rtp': 'editor-support/vim'}
Plug 'junegunn/goyo.vim'
Plug 'plasticboy/vim-markdown'
Plug 'vim-scripts/ShowTrailingWhitespace'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()
colorscheme dracula

if $COLORTERM == 'truecolor'
  set termguicolors
endif

set autoread
set signcolumn=yes " Can't decide if I like this
set tabstop=2
set softtabstop=0
set expandtab
set number
set ruler
set rulerformat=%50(%=%#SpecialKey#%F%#VisualNOS#%2c%)
set tw=79       " width of document (used by gd)
set nowrap      " don't automatically wrap on load
set fo-=t       " don't automatically wrap text when typing
" set formatoptions-=t
" set formatoptions+=c
set shiftwidth=2
set shiftround
set incsearch
set ignorecase
set smartcase
set smarttab
set expandtab
set vb t_vb=
set nobackup
set noswapfile
set virtualedit=block
set ttimeoutlen=100
set timeoutlen=500
set hlsearch
set t_ti=
" set mouse=a disable mouse to enable copy from terminal
set noshowcmd
set nolazyredraw
set inccommand=split

" Don't change the line ending
set nofixeol

let mapleader = "\<Space>"


nnoremap <C-w><C-m> <C-w>\|<C-w>_
nnoremap <C-w><C-=> <C-w>=

nmap Y y$
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-Left> <C-w>h
map <C-Right> <C-w>h
map <C-Down> <C-w>j
map <C-Up> <C-w>k
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
tnoremap <C-Left> <C-\><C-N><C-w>h
tnoremap <C-Down> <C-\><C-N><C-w>j
tnoremap <C-Up> <C-\><C-N><C-w>k
tnoremap <C-Right> <C-\><C-N><C-w>l

nnoremap * *N
nnoremap j gj
nnoremap k gk
nnoremap n nzz
nnoremap N Nzz
inoremap <S-Up> <Up>
inoremap <S-Down> <Down>
noremap <S-Up> <Up>
noremap <S-Down> <Down>

nmap <silent> ,/ :nohlsearch<CR>

tnoremap <Esc> <C-\><C-n>

" Detect filetypes
au BufNewFile,BufRead *.re set filetype=reason
au BufNewFile,BufRead *.rei set filetype=reason
au BufNewFile,BufRead *.mdx set filetype=markdown
au BufNewFile,BufRead *.lean set filetype=lean

" Turn off some things for quickfix window
au FileType qf setlocal nonumber colorcolumn=

augroup make
  au FileType make
    \ setlocal noexpandtab |
    \ setlocal tabstop=4 |
    \ setlocal shiftwidth=4
augroup END

" python-specific settings
augroup python
  au BufNewFile,BufRead *.py
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |
    \ setlocal expandtab |
    \ setlocal fileformat=unix |
augroup END

augroup markdown
  autocmd!
  autocmd FileType markdown 
    \ setlocal wrap |
    \ setlocal linebreak |
    \ setlocal conceallevel=2 |
    \ set fo-=t
augroup END


" Reverse the lines of the whole file or a visually highlighted block.
command! -nargs=0 -bar -range=% Reverse
    \       let save_mark_t = getpos("'t")
    \<bar>      <line2>kt
    \<bar>      exe "<line1>,<line2>g/^/m't"
    \<bar>  call setpos("'t", save_mark_t)
    \<bar>  :nohlsearch


" netrw settings
let g:netrw_banner=0
nmap - :Explore<CR>
" let g:netrw_list_hide= '.*\.bs.js$'

" Toggle QuickFix List
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

" Refresh vimrc after saving
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

autocmd FileType json syntax match Comment +\/\/.\+$+

" Comments
autocmd FileType ocaml setlocal commentstring=(*\ %s\ *)
autocmd FileType json setlocal commentstring=\/\/\ %s
autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->
autocmd FileType lean setlocal commentstring=--\ %s

" let s:ocamlmerlin="/Users/avery/.opam/4.07/share/merlin"

nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>
nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
map  <silent> <leader>t :Commentary<CR>
map  <silent> <leader>cc :set cursorcolumn!<CR>
xmap <silent> <leader>s :sort<CR>
vmap <silent> <leader>r :Reverse<CR>
map <silent> K :call CocAction('doHover')<CR>
map <silent> <leader>f :call CocAction('format')<CR>
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>p <C-^>
nmap <silent> <leader>b :split %:r.bs.js<CR>
nmap <silent> <leader>c :checkt<CR>
map <silent> <leader>g :Goyo<CR>

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" make error text to black color
highlight CocErrorFloat ctermfg=Black  guifg=#000000
" Make paren match less annoying
highlight MatchParen cterm=bold ctermbg=none ctermfg=red

" Set sign column to black
highlight clear SignColumn

" Turn on line numbers in Goyo
let g:goyo_linenr = 1

" Disable folding in markdown
let g:vim_markdown_folding_disabled = 1

augroup TerminalStuff
	autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
let g:neoterm_autoscroll = 1
