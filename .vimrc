let mapleader = ","

" j/k moves as expected in wrapped long lines with some quantity before
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" map H/L to start/end of the line
nnoremap H ^
nnoremap L $
xnoremap H ^
xnoremap L $

" map E to end of word + next whitespace
nnoremap E f<Space>
xnoremap E f<Space>

" map jk to escape
inoremap jk <Esc>l

" map double d to delete line
nnoremap dd Vx

" go to matching brace
nnoremap [ %
nnoremap ] %
xnoremap [ %
xnoremap ] %

"keep visual mode after indent
vnoremap > >gv
vnoremap < <gv

