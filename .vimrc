" General
set encoding=utf-8
set backspace=indent,eol,start
set nowrap
set switchbuf=usetab
set showmatch
" set tabstop=4 softtabstop=4 shiftwidth=4 smarttab shiftround

" Search
set hlsearch
set incsearch
set nowrapscan

" Completion
set wildmenu
set wildmode=list:longest,full
set wildoptions=tagfile

" Wild Ignore
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/tmp/*
set wildignore+=*.pyc,*.pyo,*.pyd,*/__pycache__/*
set wildignore+=*.so,*.o,*.dll,*.lib,*.obj,*.exe
set wildignore+=*.ttf,*.pdf,*.xls,*.xlsx,*.doc,*.docx
set wildignore+=*.h5,*.pcl,*.dat
set wildignore+=*.tar,*.gz,*.bz2
set wildignore+=*.png,*.gif,*.jpg,*.bmp,*.ico
set wildignore+=cscope.out,tags

" UI
set cursorline
set laststatus=2
set linebreak
set ruler
let showbreak='+++ ' 
set splitbelow
set splitright
set lazyredraw
let &t_ut=''

" Auto Commands
augroup CursorLine
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
    autocmd InsertEnter * set nocursorline
    autocmd InsertLeave * set cursorline
augroup end

" au FileType xml setlocal foldmethod=syntax
" let g:xml_syntax_folding=1

" Filetype
syntax on
filetype on
filetype indent on
filetype plugin on
syntax sync fromstart

" Color
colorscheme gruvbox

" Packages
packadd! supertab
packadd! vim-airline
packadd! vim-airline-themes
" packadd! ctrlp
packadd! ale
packadd! vim-gitgutter
packadd! vim-cpp-modern
packadd! python-syntax
packadd! vim-python-pep8-indent
packadd! quick-scope
packadd! vim-grepper
packadd! fzf.vim
packadd! typescript-vim
packadd! vim-nix

autocmd BufNewFile,BufRead *.ts  set filetype=typescript

" gitgutter
let g:gitgutter_terminal_reports_focus=0

" airline:
let g:airline_theme='lucius'
let g:airline_left_sep=''
let g:airline_right_sep=''

" ale
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_insert_leave=1
let g:ale_set_highlights=0
let g:ale_set_signs=0
let g:ale_set_balloons=0
let g:ale_linters={
    \ 'cpp': ['gcc'],
    \ 'python': ['flake8']
    \ }
let g:ale_cpp_gcc_options='-std=c++14 -Wall -Wextra -Wpedantic -Wconversion'
let g:ale_python_flake8_options='--ignore=E501,W291,E722' " line too long, trailing whitespace, bare except
let g:ale_c_parse_compile_commands=1

" grep/per
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor\ --column\ --vimgrep
elseif executable('rg')
	set grepprg=rg\ --vimgrep
endif
set grepformat=%f:%l:%c:%m,%f:%l:%m

let g:grepper = {}
let g:grepper.tools = ['git', 'ag', 'rg']
let g:grepper.prompt = 0

" ctrlp
" let g:ctrlp_clear_cache_on_exit=1
" let g:ctrlp_show_hidden=0
" let g:ctrlp_switch_buffer=1
" let g:ctrlp_match_window='max:10,results:100'
" let g:ctrlp_use_caching=1
" let g:ctrlp_root_markers=['cscope.out', 'tags', '.mark']
" let g:ctrlp_extensions=['buffertag']
" let g:ctrlp_by_filename=1
" let g:ctrlp_regexp=1
" let g:ctrlp_lazy_update=1
" let g:ctrlp_working_path_mode = 'rc'

" quickscope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Trigger a highlight only when pressing f and F.
let g:qs_highlight_on_keys = ['f', 'F']

" fzf
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = 'ctags -R --sorted=yes'

" python syntax
let g:python_highlight_all = 1
let g:python_version_2 = 0

" Grepper shortcuts
nmap <silent> gs <Plug>(GrepperOperator)
vmap <silent> gs <Plug>(GrepperOperator)

" fzf shortcuts
nmap <silent> <leader>f :Files<CR>
nmap <silent> <leader>g :GFiles<CR>
nmap <silent> <leader>b :Buffers<CR>
nmap <silent> <leader>t :Tags<CR>
nmap <silent> <leader>T :BTags<CR>
nmap <silent> <leader>l :Lines<CR>
