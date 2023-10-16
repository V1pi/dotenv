lua require('plugins')
lua require('plugins.configs.dap')
lua require('plugins.configs.nvimtree')
lua require('plugins.configs.telescope')
lua require('plugins.configs.lualine')
lua require('plugins.configs.bufferline')
lua require('plugins.configs.nvim-treesitter')
lua require('plugins.configs.lazygit')
lua require('core.lsp')
" themes
colorscheme dracula

autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll
nnoremap <silent> ff <cmd>lua  vim.lsp.buf.format({ timeout_ms = 2000 })<CR>

" Default sets
set tabstop=2     " Size of a hard tabstop (ts).
set shiftwidth=2  " Size of an indentation (sw).
set expandtab     " Always uses spaces instead of tab characters (et).
set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
set autoindent    " Copy indent from current line when starting a new line.
set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
set mouse=a
set number
set relativenumber
set completeopt=noinsert,menuone,noselect
set hidden
filetype plugin indent on
syntax on
set t_Co=256

" Spectre
nnoremap <leader>S <cmd>lua require('spectre').open()<CR>
"  search in current file
nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>
" run command :Spectre

" b-bye vim
set runtimepath^=~/.vim/bundle/bbye

" True color if available
let term_program=$TERM_PROGRAM

" Check for conflicts with Apple Terminal app
if term_program !=? 'Apple_Terminal'
	set termguicolors
else
	if $TERM !=? 'xterm-256color'
		set termguicolors
	endif
endif

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" maps
nnoremap <leader>ff <cmd>Telescope find_files<cr>

" BUFFER LINE
" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent><S-Right> :BufferLineCycleNext<CR>
nnoremap <silent><C-l> :BufferLineCycleNext<CR>
nnoremap <silent><S-Left> :BufferLineCyclePrev<CR>
nnoremap <silent><C-h> :BufferLineCyclePrev<CR>

" configure code actions
nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR>

" bbye-vim
nnoremap <Leader>q :Bdelete!<CR>
noremap <Leader>w :w<CR>:Bdelete<CR>

" toggle tree  
noremap <Leader>t :NvimTreeToggle<CR>
noremap <Leader>r :NvimTreeRefresh<CR>


" remove highlight
nnoremap <Leader><space> :noh<cr>

" provide hjkl movements in Insert mode via the <Alt> modifier key
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l

" TextEdit might fail if hidden is not set.
set hidden

set clipboard^=unnamed,unnamedplus
