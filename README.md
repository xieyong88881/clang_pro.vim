The vim script is small but powerful.Everyone know vim script can read this plugin and change it for yourself. That is vim's power ,do it yourself. I use it work well for ubuntu 12.04 and old winxp machine, it may work well on mac X too. 

install details
just put clang_pro.vim in your ~/.vim/plugin 
install clang and GNU GLOBAL,(apt-get install clang and for new version in global source using configure/make/make install 
install vim plugin: gtags.vim from global source and javacomplete from http://www.vim.org/scripts/script.php?script_id=1785  ; 

make a file named clang_pro at the root of your c/c++/java project. the content can be like 
when using a c/cpp pro using autotools for makefile,the sample content can be: 

set makeprg=export\ PATH=$PATH:/opt/buildroot-gcc342/bin;cd\ ~/wifidog;make 
let g:clang_options = '-I ./include -I ../include' 
"notice must use "\" before when there are  ' ' in commands 

when using a java pro using ant for make,the sample content can be: 

set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%# 
set makeprg=ant 
let g:java_classpath='.:/skyics/ics/out/host/common/obj/JAVA_LIBRARIES/layoutlib_intermediates/classes' 

When the script start ,it will find the clang_pro file and make it work,so can write any vim settings in it . 
As default ,GNU GLOBAL will make a GTAGS in the root of project, you can 
use the abilility of it which can quickly find define and callers. You can use let g:clang_options to make clang work , most of time ,include and macro define is needed. 

If you do not want a project using gtags,write:  let g:clang_use_global = 0. 

This plugin use clang and  javacomplete to auto complete c/c++/java codes ,and use gnu global(work better than cscope for c++ and can work  for java and php) make a project to find define and callers. 


For get the all utilities of the plugin,make install clang and gnu global,and put gtags.vim  in the source of global into your .vim/plugin. 
Make  a file  name is clang_pro  at the root of your c/c++/java project. 
As default key bindings,
when you want get define,just push ',' and 'd' keys on the word.push ',' and 'r' for references. 
push ',' and 'h' for h/c,cpp switch.
push ',' and 's' for save sessions.push ',' and 'l' for load sessions. 
push ',' and 'm' for will build the project using makeprg. 
When add . :: -> complete menu will pop up for you. You can also use key ctrl-x-o make the complete menu pop up manully.
When any thing wrong, use key ctrl-x-u ,you can see clang debug info at quickfix window. 


