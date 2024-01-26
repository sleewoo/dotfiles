
lua require("init")

" === generic setup ===

set confirm
set number
set cursorline

set colorcolumn=80
set updatetime=100
set signcolumn=yes

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing extra message when using completion
set shortmess+=c

" ident using 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2

" Show the current cursor position
set ruler

" Enable syntax highlighting
syntax on

" Send more characters for redraws
set ttyfast

" Enable mouse use in all modes
set mouse=a

" select with shift + arrow keys
" set keymodel=startsel

" display special chars
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»
" eol:¶

" show leader key in the bottom right corner
set showcmd

" do not save while in insert mode
let g:auto_save_in_insert_mode = 0

" Ctrl-s to save
noremap <silent> <C-S>   :update<CR>
vnoremap <silent> <C-S>  <C-C>:update<CR>
inoremap <silent> <C-S>  <C-O>:update<CR>

" Create Blank Newline and stay in Normal mode
nnoremap <silent> <A-o> :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <A-O> :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" clear highlighten items with esc
nnoremap <silent> <esc> :let @/ = ""<cr>

" copy/paste operations
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" close quickfix list
nmap <leader>q :cclose <bar> :TroubleClose<cr>

" open new empty tab next to current one
nnoremap <C-n> :tabnew<cr>

" zoom current window
nmap <silent> <C-w>z :tabnew %<CR>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

