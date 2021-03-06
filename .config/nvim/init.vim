
" === generic setup ===

" disable netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

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

" save when leaving insert mode
autocmd InsertLeave * silent! update

let mapleader = "\<Space>"

" clear highlighten items with <esc>
nnoremap <esc> :let @/ = ""<return><esc>

" copy/paste operations
vmap <leader>c "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" === 24-bit color support ===
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" === theme ===
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_status_lines = 1
let g:nord_uniform_diff_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
colorscheme nord

" === grep setup ===

set grepprg=rg
set grepformat=%f:%l:%c:%m
let g:rgargs='--vimgrep'

function! Grep(...)
  return system(join([ 'rg', g:rgargs ] + [ join(a:000, ' ') ], ' '))
endfunction

function! IGrep(...)
  return system(join([ 'rg', g:rgargs, '--ignore-case' ] + [ join(a:000, ' ') ], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar IGrep cgetexpr IGrep(<f-args>)

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
augroup end

" close quickfix list
nmap <leader>q :cclose <bar> :FloatermKill!<cr>

" grep word under cursor
nmap <leader>s :execute "Grep <c-r><c-w>"<cr>

" grep word under cursor, case insensitive
nmap <leader>si :execute "IGrep <c-r><c-w>"<cr>

" grep word under cursor, exact match
nmap <leader>w :execute "Grep '\\b<c-r><c-w>\\b'"<cr>

" grep word under cursor, exact match, case insensitive
nmap <leader>wi :execute "IGrep '\\b<c-r><c-w>\\b'"<cr>

" === fzf setup ===
let g:fzf_preview_window = [ 'up:75%:hidden', 'ctrl-/' ]

" open fzf files
nmap <leader>f :Files<cr>

" open buffer list
nmap <leader>b :Buffers<cr>

" open fzf history
nmap <leader>h :History<cr>

" toggle modified file list
nmap <leader>m :GF?<cr>

" buffer search
nmap <leader>/ :BLines<cr>

" === coc setup ===

" toggle coc-explorer
nmap <leader>e :CocCommand explorer --position=floating<cr>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" <c-h> to display docs
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <c-h> :call <SID>show_documentation()<cr>

" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)

" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)

" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)

" show commit contains current position
nmap gc <Plug>(coc-git-commit)

" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

" coc-cSpell setup
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" delimitMate setup
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1

" gitui in floating terminal
nnoremap <leader>g :FloatermNew --height=0.8 --width=0.8 --name=gitui --title=gitui gitui<cr>

" === status line and tabs ===

set laststatus=2
set showtabline=2
set noshowmode

let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'component_function': {
      \ 'filetype': 'Filetype',
      \ 'fileformat': 'Fileformat',
  \ },
  \ 'tab_component_function': {
    \ 'filename': 'TabFilename',
  \ },
\ }

function! Filetype()
  return winwidth(0) > 70
    \ ? (
          \ strlen(&filetype)
            \ ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol()
            \ : 'no ft'
      \ ) 
    \ : ''
endfunction

function! Fileformat()
  return winwidth(0) > 70
    \ ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol())
    \ : ''
endfunction

function! TabFilename(n) abort
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let path = expand('#' . buflist[winnr - 1].':p')
  return path !=# ''
    \ ? WebDevIconsGetFileTypeSymbol() . substitute(path, getcwd() . "/", " ", "")
    \ : '[No Name]' 
endfunction

