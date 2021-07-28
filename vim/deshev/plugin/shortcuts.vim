"buffers
nmap <silent> <unique> <Leader>s :Errors<CR>
map <F7> :tn<CR>
map <F4> :ToggleBufExplorer<CR>
imap <F4> <Esc>:ToggleBufExplorer<CR>
map <C-F4> :bd<CR>
nnoremap <silent> <F2> :TagbarToggle<CR>
nmap <silent> <unique> <Leader>f :Files<CR>
nmap <silent> <unique> <Leader>b :Buffers<CR>
nmap <silent> <unique> <Leader>gg :Rg<CR>
nmap <silent> <unique> <Leader>g :grep
nmap <silent> <unique> <Leader>gw :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" make sure you have your wildignore properly set to ignore unneeded files in
" projects
" map <unique> <Leader>f :e **/*
nmap <silent> <unique> <Leader>t :Tags<CR>
map <silent><F3> :cclose<CR>:lclose<CR>:TagbarClose<CR>
map <silent><leader><F3> :call tags#GenerateTags()<CR>
map <F8> :cnext<CR>
map <S-F8> :cprev<CR>
map <F5> :ALEFix<CR>

nnoremap <silent><F1> :Explore<CR>

map <silent> <F9> :TmuxRunTests<CR>
imap <silent> <F9> <Esc>:TmuxRunTests<CR>

"save
map <C-S> :wa<CR>
imap <C-S> <Esc>:wa<CR>

"replace word under cursor (ask for confirmation)
:nnoremap <Leader>r :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

"copy/paste to other apps
map <silent><Leader>y "+y
map <silent><Leader>p "+gp
imap <silent><Leader>p <C-o>"+gP
map <C-INSERT> "+y
imap <C-INSERT> <ESC>"+y
map <S-INSERT> "+gP
imap <S-INSERT> <ESC>"+gP

"insert line above insert mode
imap <M-o> <C-o>O
map <M-o> O

"Prev/Next methods
map <M-p> [m
map <M-n> ]m

"easily move across windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

map <F12> :set filetype=xml<CR>
map <S-F12> :set filetype=html<CR>

" Emacs (blasphemy!) shortcuts for cmd line and insert editing
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <M-BS> <C-W>
cnoremap <M-d> <S-Right><C-W>

inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <M-b> <S-Left>
inoremap <M-f> <S-Right>
inoremap <M-BS> <C-W>
inoremap <M-d> <S-Right><C-W>

" move up/down by visible lines instead of file lines
nnoremap j gj
nnoremap k gk
nnoremap ^ g^
nnoremap <HOME> g^
nnoremap $ g$
nnoremap <END> g$
vnoremap j gj
vnoremap k gk
vnoremap ^ g^
vnoremap <HOME> g^
vnoremap $ g$
vnoremap <END> g$

" LSP
nnoremap <space><space> :Lspsaga hover_doc<CR>
nnoremap <space>p :Lspsaga preview_definition<CR>
nnoremap <C-space> :Lspsaga signature_help<CR>
inoremap <C-space> <C-o>:Lspsaga signature_help<CR>
nnoremap <space>dd :Lspsaga show_line_diagnostics<CR>
nnoremap [d :Lspsaga diagnostic_jump_next<CR>
nnoremap ]d :Lspsaga diagnostic_jump_prev<CR>

nnoremap <space>ca :Lspsaga code_action<CR>
vnoremap <space>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <space>rn :Lspsaga rename<CR>

nnoremap <space>dd :Telescope lsp_definitions<CR>
nnoremap <space>ii :Telescope lsp_implementations<CR>
nnoremap <space>rr :Telescope lsp_references<CR>
nnoremap <space>ss :Telescope lsp_dynamic_workspace_symbols<CR>
