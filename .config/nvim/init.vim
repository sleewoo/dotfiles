
" === generic setup ===

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

" show tabline
set showtabline=2

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

" save with <leader>w
nnoremap <leader>w :w<cr>

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

set grepprg=rg\ --smart-case\ --hidden\ --vimgrep
set grepformat=%f:%l:%c:%m

function! Grep(...)
  return system(join([&grepprg] + [join(a:000, ' ')], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

" === fzf setup ===
let g:fzf_preview_window = ['up:75%', 'ctrl-/']

" open fzf files
:nnoremap <leader>f :Files<cr>

" open buffer list
:nnoremap <leader>b :Buffers<cr>

" open fzf history
:nnoremap <leader>h :History<cr>

" === coc setup ===

" toggle coc-explorer
:nnoremap <leader>e :CocCommand explorer --position=floating<cr>

" toggle modified file list
:nnoremap <leader>m :GF?<cr>

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

