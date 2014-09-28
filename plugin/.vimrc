set nocompatible
set nu
set autoindent
set showmatch     "括号匹配高亮
set ruler
set vb t_vb=    "停止报警音
set incsearch    "递进查找
set ignorecase smartcase  "忽略大小写直到有大写字母
set backspace=indent,eol,start  "使用back键可以删除所有内容
colorscheme desert
set guioptions-=T   "去掉工具栏
syntax on
filetype plugin indent on 

"for ubuntu setting
set guifont=Ubuntu\ Mono\ 14    "选择字体大小
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,gb18030

nmap <F12> :!ctags -R  --exclude=.svn<CR>       "建立tags索引
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
set tags=tags;
set autochdir

nmap ,g :vimgrep /\<<C-R><C-W>\>/ ./**/*.*
nmap ,t :Tlist<CR>
nmap ,q :call OpenCloseQuickfix()<CR>
let s:openCloseQuickfixFlag=0
func OpenCloseQuickfix()
  if s:openCloseQuickfixFlag==0
	  let s:openCloseQuickfixFlag=1
	  exe "copen"
  else
	  let s:openCloseQuickfixFlag=0
	  exe "cclose"
  endif
endfunc
nmap ,p :call OpenClosePaste()<CR>
let s:openClosePasteFlag=0
func OpenClosePaste()
  if s:openClosePasteFlag==0
	  let s:openClosePasteFlag=1
	  exe "set paste"
  else
	  let s:openClosePasteFlag=0
	  exe "set nopaste"
  endif
endfunc

nmap <F11> :!export GTAGSFORCECPP=1;gtags<CR>    "建立global索引
"nmap ,d :Gtags -a <C-R>=expand("<cword>")<CR><CR>   "查找定义，-a生成绝对路径，防止路径混乱
"nmap ,r :Gtags -a -r <C-R>=expand("<cword>")<CR><CR>   "查找引用
"nmap ,s :Gtags -a -s <C-R>=expand("<cword>")<CR><CR>  "查找非标注过的符号，比如能查找到局部变量 
"let g:Gtags_Auto_Update = 1

"use <C-V> <C-C> <C-X> <C-S> <C-Z> <C-Y> <C-A> for paste copy cut save undo redo sellectall
"noremap <C-V> "+p   只在插入模式下粘帖，防止和ctrl-v快选择冲突
inoremap <C-V> <C-O>"+p
vnoremap <C-C> "+y
vnoremap <C-X> "+x
noremap <C-S> :w<CR>    
inoremap <C-S> <C-O>:w<CR>
noremap <C-Z> u    
inoremap <C-Z> <C-O>u
noremap <C-Y> <C-R>  
inoremap <C-Y> <C-O><C-R>
noremap <C-A> gggH<C-O>G    
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G

"插入模式下移动
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-h> <left>

autocmd FileType c,cpp,python set tabstop=4|set shiftwidth=4|set expandtab
autocmd Filetype javascript,jsp,python inoremap <buffer>.  .<C-X><C-O><C-P>

let g:DirDiffTextFiles = "文件 "
let g:DirDiffTextAnd = " 和 "
let g:DirDiffTextDiffer = " 不同"
let g:DirDiffExcludes = "CVS,*.svn,*.class,*.exe,*.obj,*.o,.*.swp" 

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1


"当新建 .h .c .cpp .py .java文件时调用SetTitle 函数，自动插入文件头,可通过:call SetTitle()手动调用
autocmd BufNewFile *.[ch],*.cpp,*.py,*.java exec ":call SetTitle()"
autocmd BufReadPost *.[ch],*.cpp,*.py,*.java if getfsize(expand("%:t"))==0 | exec ":call SetTitle()" | endif
nmap <C-h> :call SetTitle()<CR>
nmap ,h :call SetChangeComment()<CR> 
func SetTitle()
     if expand("%:e") == 'h' 
	 call setline(1,"/*=============================================")  
	 call append(line("."), "*   文件名称：".expand("%:t")) 
	 call append(line(".")+1, "*   创建日期：".strftime("%Y年%m月%d日")) 
	 call append(line(".")+2, "*   描    述：") 
	 call append(line(".")+3, "==============================================*/") 
   call append(line(".")+4, "#ifndef _".toupper(expand("%:t:r"))."_H_") 
   call append(line(".")+5, "#define _".toupper(expand("%:t:r"))."_H_") 
   call append(line(".")+6, "#endif")
     elseif &filetype == 'c' 
   call setline(1,"#include \"".expand("%:t:r").".h\"") 
     elseif &filetype == 'cpp' 
   call setline(1,"#include \"".expand("%:t:r").".h\"")
		 elseif &filetype == 'python' 
	 call setline(1,"#!/usr/bin/env python")
		 elseif &filetype == 'java'  
	 call setline(1,"")
	 call append(line("."),"public class ".expand("%:t:r")."{")
   call append(line(".")+1,"}")
     endif
endfunc

func SetChangeComment()
	call feedkeys("O//changeed by xieyong," . strftime("%Y-%m-%d") ." for" )
endfunc

"括号智能匹配,支持{}[]()""'',不支持<>因为容易和小于混淆 
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " <c-r>=ClosePair('"')<CR>
inoremap ' <c-r>=ClosePair("\'")<CR>
function ClosePair(char)
if getline('.')[col('.') - 1] == a:char
return "\<Right>"
endif
if a:char == '"'
return "\"\"\<LEFT>"
endif
if a:char == "\'"
return "\'\'\<LEFT>"
endif
return a:char
endf

"实现文件内,其他buffer,tags,key等的自动完成
set complete=.,w,b,k,u,t
autocmd CursorMovedI * call BufferAutoComplete()

let s:lastCol=0   "用来判断是否重复触发
fun! BufferAutoComplete()	
	set completeopt=menuone,longest
	if s:lastCol !=col('.')&&(getline('.')[col('.')-2] =~ '\w')&&(getline('.')[col('.')-3] =~ '\w')
		call feedkeys( "\<c-n>\<c-p>")
		set completeopt=menuone
	endif
	let s:lastCol=col('.')
endfun

"用tab实现ctrl-x-o,和模板实现冲突,clang_pro中有更好实现
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-o>"



