call plug#begin()

" Tim Pope Plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'

" Code Completion
Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Search code (Ack/grep)
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim' | Plug 'FelikZ/ctrlp-py-matcher'
Plug 'yssl/QFEnter'
Plug 'inside/vim-search-pulse'

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" Start screen for vim
Plug 'mhinz/vim-startify'

" Change case of word (snake-case, kebab case, etc..)
Plug 'arthurxavierx/vim-caser'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/seoul256.vim'

" Colorscheme
Plug 'fenetikm/falcon'
Plug 'kien/rainbow_parentheses.vim'
Plug 'KKPMW/distilled-vim'
Plug 'connorholyday/vim-snazzy'
Plug 'morhetz/gruvbox'

Plug 'majutsushi/tagbar'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'jiangmiao/auto-pairs'

Plug 'mbbill/undotree'

" Git stuff
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-signify'
Plug 'jreybert/vimagit'

" Todos, orgmode, etc...
Plug 'dhruvasagar/vim-dotoo'

" Writing
Plug 'rhysd/vim-grammarous'
Plug 'reedes/vim-colors-pencil'

" Tex
Plug 'lervag/vimtex'

" Pandoc
Plug 'vim-pandoc/vim-pandoc' | Plug 'vim-pandoc/vim-pandoc-syntax' | Plug 'vim-pandoc/vim-pandoc-after'

" Shougo's stuff
Plug 'Shougo/unite.vim' " | Plug 'Shougo/vimfiler.vim'

" Python stuff
Plug 'davidhalter/jedi-vim'
Plug 'fisadev/vim-isort'
Plug 'tmhedberg/SimpylFold'
"Plug 'jmcantrell/vim-virtualenv'
"Plug 'cjrh/vim-conda'
"Plug 'nvie/vim-flake8'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tell-k/vim-autopep8'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'alfredodeza/pytest.vim'

" JavaScript stuff
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'

" HTML stuff
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'wavded/vim-stylus'

" Syntax checking
Plug 'vim-syntastic/syntastic'

" Cool stuff
Plug 'metakirby5/codi.vim'
Plug 'RRethy/vim-illuminate'

" Switch plugin
Plug 'AndrewRadev/switch.vim'

" Interoperability with tmux
Plug 'christoomey/vim-tmux-navigator'

" Carto vim plugin
Plug '~/repos/vim-carto'

" Tradewind plugin for moving windows around
Plug 'andymass/vim-tradewinds'

" Graphviz dot files
Plug 'wannesm/wmgraphviz.vim'

call plug#end()

nmap ; :

set encoding=utf-8

" Simple session management
let g:sessions_dir = '~/vim-sessions'
exec 'nnoremap <Leader>ss :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'

" Make vim aware of pipenv
let pipenv_venv_path = system('pipenv --venv')
if shell_error == 0
    let venv_path = substitute(pipenv_venv_path, '\n', '', '')
    let g:ycm_python_binary_path = venv_path . '/bin/python'
    "let python_executable = venv_path . '/bin/python'
    let python_executable = 'pipenv run python'
else
    let python_executable = 'python'
endif

" Allow to execute python scripts easily using :make
au FileType python
            \ let &makeprg=python_executable . ' %' |
            \ set autowrite

" Appearance (colorscheme and fonts)
let g:seoul256_background=233
set guifont=Roboto\ Mono\ for\ Powerline\ 14
"colorscheme seoul256
let g:SnazzyTransparent = 1
"colorscheme snazzy
colorscheme gruvbox
set background=dark
let g:airline_theme='gruvbox'

" Make background transparent
autocmd VimEnter * hi Normal ctermbg=none

" My <Leader> key is ','
let mapleader=","
let maplocalleader="\\"

" Save with C-S and switch to normal mode
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

nmap <c-a> ,c<space>
vmap <c-a> ,c<space>

" Traverse long lines intuitively
nnoremap j gj
nnoremap k gk

" Makes the newly created vsp window open on the right
set splitright

" Easily add newline from normal mode
nmap <CR> o<Esc>k
nmap <S-CR> O<Esc>j

" Make window navigation easy!
set wmh=0
set wmw=0

" When opening anew document - keep all folds open
let foldlevelstart=99

" Disable ex mode - never use it and its confusing
map Q <Nop>

"open .vimrc fast
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>

" Enable spell checking
set spell
set spelllang=en

" Go back to last misspelled word and pick first suggestion.
inoremap <C-B> <C-G>u<Esc>[s1z=`]a<C-G>u

" Vimcast #1: show invisibles
set listchars=tab:▸\ ,eol:¬
nmap <leader>l :set list!<CR>

" Remove trailing whitespaces on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    keepp %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python,javascript,vue autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Make vim copy and paste using the "* register so that it yanks directly into
" the clipboard
set clipboard=unnamedplus

" Turn off bell for all messages/notifications
set bo=all

" Airline configuration
let g:airline_section_z = '%p%%'
let g:airline_section_a = ''
let g:airline_powerline_fonts = 1

" Add some window resize functionality
nnoremap <C-Right> : vertical resize +5<CR>
nnoremap <C-Left>  : vertical resize -5<CR>
nnoremap <C-Up>    : resize -1<CR>
nnoremap <C-Down>  : resize +1<CR>

" Move around with C-{jkhl} between windows
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-h> <c-w>h
nnoremap <C-l> <c-w>l

nnoremap <A-j> <c-w><c-j><c-w><c-_>
nnoremap <A-k> <c-w><c-k><c-w><c-_>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|git\|site-packages\|frontend_bak\|/dashboard/\|venv\|default_app\|default_temp\|\.wt$\|\.bson|\.ipynb$'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Adjust QFEnter to use similar mappings to Ctrl-P
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

" Make zt a little nicer to use
nmap zt zt3<C-Y>

" Show line number
set number

" Highlight line where cursor is
set cursorline

" Show the row and column position of the cursor
set ruler

" Hide buffers instead of closing them (preserves history)
set hidden

" By default, don't need the buttons in the top row
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=L

" Definitions to make gundo work
let g:gundo_preview_bottom=1
set undofile
set colorcolumn=80

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" Toggle real fullscreen (no buttons and menu)
function ToggleFullScreen()
  call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endfunction

" F-mappings
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :UndotreeToggle<CR>
"autocmd FileType python map <buffer> <F4> :call Flake8()<CR>
nnoremap <F5> :Switch<CR>
nnoremap <F7> :TagbarToggle<CR>
nnoremap <F9> :Make<CR>
noremap <silent>  <F11> :call ToggleFullScreen()<CR>


" Searching
set ignorecase
set smartcase

" Tab stops
set tabstop=4 
set shiftwidth=4 
set softtabstop=4 
set expandtab

" History and file management
set history=1000
set undolevels=1000
set wildignore+=*.swp,*.bak,*.pyc,*.class,*.svn,*.png,*.jpg,*.gif,*.orig
set title
set nobackup
set noswapfile

" Hide buffers instead of closing them (preserves history)
set hidden

set ttyfast

set laststatus=2

" Make syntax highlighting not broken
autocmd BufEnter * :syntax sync fromstart

" Reformat a paragraph fast (i.e. to respect textwidth)
vnoremap Q gq
nnoremap Q gqap

" Make ctrl-backspace delete the word before the cursor (also in insert mode).
inoremap <C-BS> <C-O>b<C-O>dw 
noremap <C-BS> bdw

set nowrap
set linebreak
au FileType pandoc set formatoptions+=wanjc
au FileType javascript,html set formatoptions-=t
set textwidth=78


" JavaScript linting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'
let g:syntastic_python_checkers = ['prospector']

" Emmet configuration
"let g:user_emmet_leader_key = '<C-y>'

" For vim-pandoc
let g:pandoc#after#modules#enabled = ["ultisnips"]

" ---- ULTISNIPTS ----
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-space>"
let g:UltiSnipsJumpBackwardTrigger="<c-shift-space>"
let g:UltiSnipsSnippetDirectories=["UltiSnips","Snippets"]
let g:ultisnips_python_style="numpy"
let g:UltiSnipsEditSplit="vertical"

" Automatically change current directory per buffer
"fun! CDToCurrentFile()
  "exec ":cd %:p:h"
"endfun

"autocmd BufEnter * silent! lcd %:p:h

fun! LightColorScheme()
      let g:pencil_higher_contrast_ui = 1
      let g:pencil_neutral_code_bg = 1
      let g:airline_theme='pencil'
      colorscheme pencil
      set background=light
      hi Conceal guifg=#424242 guibg=#F1F1F1
      set guifont=Cousine\ for\ Powerline\ 14
endfun

fun! DarkColorScheme()
    let g:seoul256_background=233
    set guifont=Roboto\ Mono\ for\ Powerline\ 14
    "colorscheme seoul256
    "colorscheme snazzy
    "let g:SnazzyTransparent = 1
    colorscheme gruvbox
    set background=dark
    "let g:airline_theme='deus'
    let g:airline_theme='gruvbox'
endfun

"autocmd FileType markdown,pandoc,tex,latex call LightColorScheme()
"autocmd FileType python,JavaScript,vue,html,css,txt call DarkColorScheme()
autocmd FileType python set tabstop=4
autocmd FileType vue syntax sync fromstart

" Makes it possible to use NerdCommenter with vue
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

nnoremap - za


" Jedi stuff
let g:jedi#max_doc_height=15
let g:jedi#show_call_signatures_delay=100
let g:jedi#completions_enabled=0

" SimplyFold stuff
let g:SimpylFold_fold_import = 0
"let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_docstring_preview = 1

" Switch definitions
let g:switch_custom_definitions = 
            \ [
            \    {'\(.*\)True\(.*\)' : '\1False\2'},
            \    {'\(.*\)False\(.*\)' : '\1True\2'},
            \    {'rep = 5': 'rep = 100'},
            \    {'rep = 100': 'rep = 5'},
            \ ]

let g:pandoc#formatting#mode = 'ha'

" Allow ycm to run on pandoc
"let g:ycm_filetype_blacklist = {
    "\ 'tagbar' : 1,
    "\ 'qf' : 1,
    "\ 'notes' : 1,
    "\ 'unite' : 1,
    "\ 'text' : 1,
    "\ 'vimwiki' : 1,
    "\ 'infolog' : 1,
    "\ 'mail' : 1
    "\}
    "
    "
" Help JEDI find anaconda's python interpreter
"let g:ycm_python_binary_path = '/home/omri/anaconda3/bin/python'


let NERDTreeIgnore=['\.pyc$', '\~$']

let g:vimtex_view_method='zathura'

" Disable overfull/underfull \hbox and all package warnings
let g:vimtex_quickfix_latexlog = {
    \ 'default' : 0
\}

let g:tex_flavor = "latex"

"let g:vimtex_quickfix_warnings = {
            "\ 'default' : 0
            "\}
let g:vim_isort_python_version = 'python3'

map <leader>jt <Esc>:%!json_xs -f json -t json-pretty<CR>

autocmd VimEnter * :AirlineRefresh

" Allow executing macro on visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" temporary settings for pandoc
let g:pandoc#command#autoexec_command='Pandoc beamer -Vtheme:metropolis --pdf-engine=xelatex --slide-level=2'
let g:pandoc#command#autoexec_on_writes=1
"let g:pandoc#command#autoexec_command='Pandoc pdf -f gfm'
"

" Change bindings because of switch to i3
let g:AutoPairsFastWrap = '<Ctrl+e>'
au FileType python let g:AutoPairs["'''"] = "'''"
au FileType python let g:AutoPairs['"""'] = '"""'
au FileType python let g:AutoPairs["f'"] = "'"
