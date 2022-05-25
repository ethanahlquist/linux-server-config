"-----------------------------------------
" Ethan Ahlquist's Vimrc:
"-----------------------------------------



" Trial Period {{{
set cindent cinkeys-=0#
set expandtab shiftwidth=4 tabstop=4 softtabstop=4

" }}}



" Basics {{{

syntax enable
filetype plugin on
filetype on

"}}}



" Settings {{{

"colorscheme elflord
set nocompatible     " enter current mullenium

set nu               "Line Numbering:
set rnu              "Relative Line Numbering:

set tabstop=4
set shiftwidth=4
set expandtab

set cindent
set smarttab

set bs=2                "Allows backspace in (Insert):

set nohlsearch
set showcmd
set encoding=utf-8


set wildmenu            " Display all matching files when we tab complete
"                             \
"                                - > hit tab to :find by partial match
"                                - > Use * to make it fuzzy

" Enable autocompletion:
set wildmode=longest,list,full         


"search down in subfolders (Provides tab-completion for all file related tasks)
set path+=**         

" }}}



" Quick Change {{{ 


"make increment and decrement also work with letters
"set nrformats+=alpha


" No swapfiles in current directory
" set directory=/tmp//              


"searches as you enter search string
"set incsearch

" Set to auto read when a file is changed from the outside
"set autoread

"Highlight search things
"set hlsearch

"limit text lines to 80 characters. Will create new line when this is exceeded.
"set textwidth=80


" }}}



" Preferences {{{ 

" Disables automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o   

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright   

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	vnoremap <C-c> "+y
	map <C-p> "+P

" Automatically deletes all trailing whitespace on save.
"	autocmd BufWritePre * %s/\s\+$//e

set mouse=a

set foldmethod=marker

"show the current row and column at the bottom of the screen
set ruler

" Sets how many lines of history VIM has to remember
set history=700

"Ignore case when searching
set ignorecase
set smartcase

"use this for black/dark terminal background
set background=dark

"Not sure about this!
set rtp+=~/.fzf

"THIS IS MOST LIKELY CAUSING BASH SPACING ISSUES:
" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon
" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

" }}}



" Mappings {{{

inoremap jk <Esc>
inoremap jj <Esc>
inoremap kj <Esc>
inoremap kk <Esc>

inoremap <S-Tab> <C-D>

" Shortcutting split navigation, saving a keypress:
	noremap <C-h> <C-w>h
	noremap <C-j> <C-w>j
	noremap <C-k> <C-w>k
	noremap <C-l> <C-w>l

" subsutite
   nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
   vnoremap <Leader>s y:%s/<C-R>=escape(@",'/\$^*')<CR>/

" Find
   vnoremap <Leader>f y/\V<C-R>=escape(@",'/\')<CR><CR>

" This is a way to toggle spelling correction quickly
   nnoremap <C-s>p :set spell!<CR>           
   nnoremap <C-s><C-p> :set spell!<CR>

" }}}



" C / C++ Specific {{{1

      " Automatically deletes all trailing whitespace on save.

	   autocmd FileType c,cpp autocmd BufWritePre * %s/\s\+$//e
	   autocmd FileType c,cpp set cindent
	   "autocmd FileType c,cpp autocmd BufWritePost :make
      autocmd BufWritePost *.cpp,*.c make


   " Abbreviations {{{2
      autocmd FileType c,cpp inoreab <buffer> cmain 
      \#include <stdio.h>
      \<CR>#include <string.h>
      \<CR>#include <stdlib.h>
      \<CR>#include <assert.h>
      \<CR>#include <limits.h>
      \<CR>#include <float.h>
      \<CR>#include <unistd.h>
      \<CR>#include <sys/types.h>
      \<CR>#include <sys/wait.h>
      \<CR>#include <libgen.h>
      \<CR>
      \<CR>int main(int argc, char *argv[]) {
      \<CR>
      \<CR>printf("Hello World\n");
      \<CR>return 0;
      \<CR>
      \<CR>}
      \<CR>
      \<CR>void function(int i) {
      \<CR>
      \<CR>
      \<CR>}


      autocmd FileType c,cpp inoreab nfor 
      \<CR>for(i = 0; i < count; i++){
      \<CR>l<BS>
      \<CR>statement(s);
      \<CR>l<BS>
      \<CR>}<Esc><<o<Esc>


      autocmd FileType c,cpp inoreab wfor 
      \<CR>for(i = 0; i < count; i++){
      \<CR><CR>}<Esc><<ddV'm>'mpo<Esc>


      autocmd FileType c,cpp inoreab wif 
      \<CR>if( condition ){
      \<CR><CR>}<Esc><<ddV'm>'mpo<Esc>


      autocmd FileType c,cpp inoreab cheader 
      \<CR>#ifndef FILE_H
      \<CR>#define
      \<CR>
      \<CR>#include whatever.h
      \<CR>
      \<CR>
      \<CR>
      \<CR>
      \<CR>
      \<CR>#endif
      \<CR><Esc>5ki
   "}}}

"}}}



" Text File Specific: {{{


   " Settings {{{


   " }}}



   " Abbreviations {{{
      autocmd FileType text inoreab nheader
      \<CR>################################################################################
      \<CR>#
      \<CR># Author: Ethan Ahlquist
      \<CR>#
      \<CR># Date: <Esc>:put =strftime(\"%b %d, %Y\")<Enter>i<BS><Esc>o
      \#
      \<CR># Class: <Esc>:put =expand('%:p:h:t')<Enter>i<BS><Esc>o
      \#
      \<CR># Title: <Esc>:put =expand('%:r')<Enter>i<BS><Esc>o
      \#
      \<CR>################################################################################<Esc>

      autocmd FileType text inoreab fold 
      \{{{
      \<CR><CR>}}}<Esc><<ddV'm>'mpza

   "}}


" }}}

"}}}



" MARKDOWN {{{1
  autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
  autocmd BufRead,BufNewFile *.md set filetype=markdown

   augroup filetype_markdown " {
      autocmd!
      autocmd Filetype markdown cmap <buffer> pdf !mdViewPDF % &
      autocmd Filetype markdown cmap <buffer> initpdf !mdInitPDF % &
      autocmd Filetype markdown cmap <buffer> cauto autocmd BufWritePost <buffer> !mdUpdatePDF % &
      " autocmd FileType markdown autocmd BufWritePost <buffer> !mdUpdatePDF %

      autocmd FileType markdown inoreab <buffer> nheader 
      \---
      \<CR>title: <Esc>:put =expand('%:r:t') <Enter>i<BS><Esc>o
      \author: Ethan Ahlquist
      \<CR>date: <Esc>:put =strftime(\"%b %d, %Y\")<Enter>i<BS><Esc>o
      \geometry: margin=3cm
      \<CR>output: pdf_output
      \<CR>--- 

      autocmd FileType markdown inoreab <buffer> nimage ![Title](link) 

   augroup END " }



  "autocmd Filetype markdown :autocmd BufWritePost * :!mdViewPdf %

"  autocmd BufRead,BufNewFile /tmp/calcurse* insert \<CR>#include <stdio.h>
"      \<CR>
"      \<CR>int main(void) {
"      \<CR><Tab>
"      \<CR><Tab>printf("Hello World\n");
"      \<CR>return 0;
"      \<CR>
"      \<CR>}<Esc><<
"  autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=groff

" }}}



" LaTeX {{{1

   " Abbreviations {{{2
   
      autocmd FileType c,cpp inoreab nfor 
      \<CR>for(i = 0; i < count; i++){
      \<CR>l<BS>
      \<CR>statement(s);
      \<CR>l<BS>
      \<CR>}<Esc><<o<Esc>

      autocmd Filetype tex cmap <buffer> cauto autocmd BufWritePost <buffer> !pdflatex %
   "}}}




"}}}



" FUTURE STUFF {{{

"-------------------------------------------
" GO AWAY, YOU AREN'T SUPPOSED TO BE HERE!
"-------------------------------------------

" copy yank buffer to system clipboard
" Usr OSC52 to put things into system clipboard, works over ssh

" function! Osc52Yank()
"    let buffer=system('base64 -w0', @0) " -w0 to dissable76 char line wrapping
"    let buffer='\ePtmux;\e\e]52;c;'.buffer.'\x07\e\\'
"    silent exe"!echo -ne ".shellescape(buffer)." > ".shellescape(g:tty)
" endfunction
"
" nnoremap <leader>y :call 0sc52Yank()<CR>



" Other version:
"
" function! Osc52Yank()
"    let buffer=system('base64 -w0', @0)
"    let buffer=substitute(buffer, "\n$", "", "")
"    let buffer='\e]52;c;'.buffer.'\x07'
"    silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape("/dev/pts/0")
"endfunction
"command! Osc52CopyYank call Osc52Yank()
"augroup Example
"    autocmd!
"    autocmd TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
"augroup END



"use python indentation style and syntax highlighting for python
"autocmd FileType py set tabstop=4
"autocmd FileType py set shiftwidth=4
"autocmd FileType py set expandtab
"autocmd FileType py setf python




"Compliers:

" This calls to complile different filetypes (Found On Stack Overflow):

"//compile
":!javac %
"
"//run
":!java -cp %:p:h %:t:r
"
"autocmd Filetype java set makeprg=javac\ %
"set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
"
"command Header       :call CreateCustomHeader()<CR>
"
"func! CreateCustomHeader()



"map <F5> :call CompileRunGcc()<CR>
"func! CompileRunGcc()
"exec "w"
"
":cd %:p:h <CR> :! javac %:t<CR> :! java %:t:r<CR>
"if &filetype == 'c'
"exec "!gcc % -o %<"
"exec "!time ./%<"
"elseif &filetype == 'cpp'
"exec "!g++ % -o %<"
"exec "!time ./%<"
"elseif &filetype == 'java'
"exec "!javac %"
"exec "!time java -cp %:p:h %:t:r"
"elseif &filetype == 'sh'
"exec "!time bash %"
"elseif &filetype == 'python'
"exec "!time python2.7 %"
"elseif &filetype == 'html'
"exec "!firefox % &"
"elseif &filetype == 'go'
"exec "!go build %<"
"exec "!time go run %"
"elseif &filetype == 'mkd'
"exec "!~/.rim/markdown.pl % um> %.html &"
"exec "!firefox %.html &"
"endif
"endfunc

"}}}
