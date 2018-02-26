" Load Plugs from external file
 if filereadable(expand("~/.vimrc.bundles"))
   source ~/.vimrc.bundles
 endif

 if filereadable(expand("~/.vimrc.mappings"))
   source ~/.vimrc.mappings
 endif

" solarized theme
set background=dark
colorscheme solarized

" set yy, D, P to work w/ clipboard / Not sure if this works?
set clipboard=unnamed 

filetype plugin indent on
set expandtab " turns tabs to spaces
set tabstop=2 " number of spaces vim turns a tab into on load
set softtabstop=2 " number of spaces a tab counts for
set shiftwidth=2
set number " line numbers
set cursorline " highlights current line
set wildmenu " visual autocomplete
set lazyredraw " vim only redraws when needed (faster macros)
set incsearch " search as characters are entered
set autowrite " auto :write before running commands
set ttyfast
" set hlsearch " highlights matches
" set foldenable " enable folding
" set foldlevelstart=10 " open most folds by default
" set foldnestmax=10 " 10 nested fold max
" set foldmethod=syntax " fold based on syntax 
set noeb vb t_vb= " disable beeping
set textwidth=80
" Start scrolling when certain distance from edges of window.
set scrolloff=8
set sidescrolloff=15
set sidescroll=1
set splitbelow " opens new panes below instead of above
set splitright " opens new panes to the right instead of left
set history=50
set backupdir=~/.vim/backup
set directory=~/.vim/backup
let g:ruby_path = system('echo $HOME/.rbenv/shims')

" Plugin settings
" let g:mta_filetypes = { 'javascript.jsx': 1, 'html': 1 } " Allow MatchTagAlways to highlight JSX
let g:airline_solarized_bg='dark'| " Set airline theme for custom statusline
" rounded separators (extra-powerline-symbols):
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"
" set the CN (column number) symbol:
let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])
let g:closetag_filenames = '*.html.erb,*.html,*.xhtml,*.phtml,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'| " Shortcut for closing tags, default is '>'
let g:closetag_close_shortcut = '<leader>>'| " Add > at current position without closing the current tag, default is ''
let NERDTreeAutoDeleteBuffer = 1| " autodelete the buffer of the file you deleted with NerdTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Change cursor to line in insert mode 
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
\ endif

" set syntax highlight for specific filetypes
autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
