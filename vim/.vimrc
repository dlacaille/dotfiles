set clipboard=unnamed

" Tab navigation
nnoremap L :bnext<CR>
nnoremap H :bprevious<CR>

" Leader maps
nnoremap <leader>w :w<CR>

" Quick visual indent
vnoremap < <gv
vnoremap > >gv

" Operator maps
onoremap ib i(
onoremap ab a(
onoremap ic i{
onoremap ac a{
onoremap is i'
onoremap as a'
onoremap id i"
onoremap ad a"

" Visual selection maps
nnoremap vib vi(
nnoremap vab va(
nnoremap vic vi{
nnoremap vac va{
nnoremap vis vi'
nnoremap vas va'
nnoremap vid vi"
nnoremap vad va"