
set confirm
set number
set cursorline
set cc=80
set updatetime=1000
set signcolumn=yes

" ident using 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2

" Show a status line
set laststatus=2

" Show the current cursor position
set ruler

" Enable syntax highlighting
syntax on

" Send more characters for redraws
set ttyfast

" Enable mouse use in all modes
set mouse=a

" display special chars
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»
" eol:¶

" do not save while in insert mode
let g:auto_save_in_insert_mode = 0

let mapleader = "\<Space>"

" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
" set ttymouse=xterm2

" 24-bit color support
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" theme
" set background=dark " for the dark version
" set background=light " for the light version
colorscheme one
" let g:airline_theme='one'

" fzf setup
let g:fzf_preview_window = ['up:75%', 'ctrl-/']

" <Leader>co to close other buffers
:nnoremap <Leader>co :Bdelete other<cr>

" toggle coc-explorer
:nnoremap <Leader>e :CocCommand explorer --position=floating<cr>

" toggle modified file list
:nnoremap <Leader>m :GF?<cr>

" toggle fzf files
:nnoremap <Leader>f :Files<cr>

" toggle fzf history
:nnoremap <Leader>h :History<cr>

" >>> search in files
" toggle search dialog
:nnoremap <Leader>g :RG<cr>

" delegate searching to rg
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --hidden --color=always -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let node_info = CocAction('runCommand', 'explorer.getNodeInfo', 0)
  if type(node_info) == type({}) && node_info['directory']
    let dir = fnamemodify(node_info['fullpath'], ':p')
    CocCommand explorer --toggle --position=floating
  else
    let dir = ''
  endif
  let spec = { 'dir': dir, 'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command] }
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" <<<

" >>> coc-related setup
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" <<<

nnoremap <Leader>w :w<CR>
nnoremap <esc> :let @/ = ""<return><esc>

" <c-h> to display docs
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <c-h> :call <SID>show_documentation()<cr>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

