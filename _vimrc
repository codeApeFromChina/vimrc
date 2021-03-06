" File: _vimrc
" Author: mingcheng<i.feelinglucky@gmail.com>
" Description: mingcheng's personal vim config file.
" Last Modified: $Id: _vimrc 467 2010-05-11 03:49:05Z i.feelinglucky $
" Blog: http://www.gracecode.com/
" Since: 2008-10-07
" Change:
" [+]new feature  [*]improvement  [!]change  [x]bug fix
"
" [!] 2013-06-27
"     A Bit change syntax configure for command line use.
"
" [!] 2012-08-24
"     小范围调整和更新部分配置
"
" [*] 2010-11-23
"     改进 Vim7.3 相关的配置，使其支持 UNIX 系统
"
" [!] 2010-11-22
"     增加 void 配色，更改配色设置（蛋疼）
"
" [!] 2010-10-14
"     更改配色为 Son of Obsidian，参见 http://studiostyl.es/schemes/son-of-obsidian
"
" [+] 2010-09-13
"     增加永久撤销（for Vim7.3）相关配置
"
" [*] 2010-08-25
"     修改 Vimwiki 命令和快捷键
"
" [!] 2010-07-26
"     修改 status bar 显示 git 状态（已取消）
"
" [*] 2010-06-17
"     重新配置 Mac 下的字体
"
" [+] 2010-05-11
"     给 Win32 下的 gVim 窗口设置透明度
"
" [+] 2010-04-22
"     修改 <Leader> 键为 ','
"
" [+] 2010-04-21
"     增加 wildmenu 选项，同时修改“雅黑”字体为英文名称
"
" [+] 2010-04-09
"     增加各文件类型不同的配色选项
"     设置自动更换当前目录
"
" [+] 2010-03-30
"     设置 F2 为调用出 BufExplorer
"
" [*] 2010-03-26
"     增加 VimWiki 配置选项
"
" [+] 2010-01-20
"     Mac 下使用幼圆字体
"
" [+] 2010-01-18
"     修改部分搜索配置
"
" [*] 2009-12-22
"     Mac 下修改 GUI 界面配置
"
" [*] 2009-12-18
"     增加 Mac 下 jsl 配置
"
" [*] 2009-12-12
"     增加 Mac 下的字体设置
"
" [*] 2009-12-11
"     修复在 Mac 下的部分 Bug
"
" [*] 2009-12-08
"     增加针对 Mac 系统的支持
"
" [*] 2009-12-01
"     更新 Javascript 语言文件，增加自动补全脚本
"
" [!] 2009-10-14
"     调整修改部分配置，@TODO 改进 SelectAll 函数
"
" [!] 2009-09-24
"     为了不与 SinpMate 冲突，使用 VimWiki 插件默认快捷键
"
" [!] 2009-07-10
"     重新整理 Vim 配置文件结构
"
" [*] 2009-07-05
"     增加 ActionScript 语法支持
"     
" [*] 2009-05-31
"     增加 javascript_enable_domhtmlcss 变量，用于 JavaScript 语法高亮
"
" [!] 2009-05-07
"     快捷键： Q 退出；增加、更改 Tab 相关的快捷键
"
" [!] 2009-05-04
"     改进 Windows 字体配置，使其能使用任何中文名称
"
" [!] 2009-04-28
"     更改 Windows 快捷键，直接使用 mswin.vim
"
" [!] 2009-04-21
"     加入相应的 au 命令，避免使用 VimWiki 折叠
"
" [!] 2009-04-01
"     分离配置文件，将私人配置（包括 Twitter 相关的插件）独立出本文件
"
" [+] 2009-04-01
"     增加全屏插件，绑定 <f11>
"
" [+] 2009-02-12
"     初始化版本，啥时开始的无从考证 :^D
"

if v:version < 700
    echoerr 'This _vimrc requires Vim 7 or later.'
    quit
endif

" 获取当前目录
func! GetPWD()
    return substitute(getcwd(), "", "", "g")
endf

" 跳过页头注释，到首行实际代码
func! GotoFirstEffectiveLine()
    let l:c = 0
    while l:c<line("$") && (
                \ getline(l:c) =~ '^\s*$'
                \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*Comment.*"
                \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*PreProc$"
                \ )
        let l:c = l:c+1
    endwhile
    exe "normal ".l:c."Gz\<CR>"
endf

" 匹配配对的字符
func! MatchingQuotes()
    inoremap ( ()<left>
    inoremap [ []<left>
    inoremap { {}<left>
    inoremap " ""<left>
    inoremap ' ''<left>
endf

" 返回当前时期
func! GetDateStamp()
    return strftime('%Y-%m-%d')
endf

" 全选
func! SelectAll()
    let s:current = line('.')
    exe "norm gg" . (&slm == "" ? "VG" : "gH\<C-O>G")
endf

" From an idea by Michael Naumann
func! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunc


" ============
" Environment
" ============
" 保留历史记录
set history=500

" 行控制
set linebreak
set nocompatible
set textwidth=80
set wrap

" 标签页
set tabpagemax=9
set showtabline=2

" 控制台响铃
set noerrorbells
set novisualbell
set t_vb= "close visual bell

" 行号和标尺
set number
set ruler
set rulerformat=%15(%c%V\ %p%%%)

" 命令行于状态行
set ch=1
set stl=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ [PWD]\ %r%{GetPWD()}%h\ %=\ [Line]%l/%L\ %=\[%P]
set ls=2 " 始终显示状态行
set wildmenu "命令行补全以增强模式运行

" 定义 <Leader> 为逗号
let mapleader = ","
let maplocalleader = ","

" Search Option
set hlsearch  " Highlight search things
set magic     " Set magic on, for regular expressions
set showmatch " Show matching bracets when text indicator is over them
set mat=2     " How many tenths of a second to blink
set noincsearch

" 制表符
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" 状态栏显示目前所执行的指令
set showcmd 

" 缩进
set autoindent
set smartindent

" 自动重新读入
set autoread

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start

" 设定在任何模式下鼠标都可用
set mouse=a

" 自动改变当前目录
if has('netbeans_intg')
    set autochdir
endif

" 备份和缓存
"set nobackup
"set noswapfile

" 自动完成
set complete=.,w,b,k,t,i
set completeopt=longest,menu

" 代码折叠
set foldmethod=marker

" =====================
" 多语言环境
"    默认为 UTF-8 编码
" =====================
if has("multi_byte")
    set encoding=utf-8
    " English messages only
    "language messages zh_CN.utf-8
    
    if has('win32')
        language english
        let &termencoding=&encoding
    endif

    set fencs=utf-8,gbk,chinese,latin1
    set formatoptions+=mM
    set nobomb " 不使用 Unicode 签名

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" 永久撤销，Vim7.3 新特性
if has('persistent_undo')
    set undofile

    " 设置撤销文件的存放的目录
    if has("unix")
        set undodir=/tmp/,~/tmp,~/Temp
    else
        set undodir=d:/temp/
    endif
    set undolevels=1000
    set undoreload=10000
endif


" =========
" AutoCmd
" =========
if has("autocmd")
    filetype plugin indent on

    " 括号自动补全
    func! AutoClose()
        :inoremap ( ()<ESC>i
        :inoremap " ""<ESC>i
        :inoremap ' ''<ESC>i
        :inoremap { {}<ESC>i
        :inoremap [ []<ESC>i
        :inoremap ) <c-r>=ClosePair(')')<CR>
        :inoremap } <c-r>=ClosePair('}')<CR>
        :inoremap ] <c-r>=ClosePair(']')<CR>
    endf

    func! ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf

    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=80
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
    augroup END

    " Auto close quotation marks for PHP, Javascript, etc, file
    au FileType php,javascript exe AutoClose()
    au FileType php,javascript exe MatchingQuotes()

    " Auto Check Syntax
    au BufWritePost,FileWritePost *.js,*.php call CheckSyntax(1)

    " JavaScript 语法高亮
    "au FileType html,javascript let g:javascript_enable_domhtmlcss = 1
    "au BufRead,BufNewFile *.js setf jquery

    " 给各语言文件添加 Dict
    if has('win32')
        let s:dict_dir = $VIM.'\vimfiles\dict\'
    else
        let s:dict_dir = $HOME."/.vim/dict/"
    endif
    let s:dict_dir = "setlocal dict+=".s:dict_dir

    au FileType php exec s:dict_dir."php_funclist.dict"
    au FileType css exec s:dict_dir."css.dict"
    au FileType javascript exec s:dict_dir."javascript.dict"

    " 格式化 JavaScript 文件
    au FileType javascript map <f12> :call g:Jsbeautify()<cr>
    au FileType javascript set omnifunc=javascriptcomplete#CompleteJS

    " 增加 ActionScript 语法支持
    au BufNewFile,BufRead,BufEnter,WinEnter,FileType *.as setf actionscript 

    " CSS3 语法支持
    au BufRead,BufNewFile *.css set ft=css syntax=css3

    " 增加 Objective-C 语法支持
    au BufNewFile,BufRead,BufEnter,WinEnter,FileType *.m,*.h setf objc

    " 将指定文件的换行符转换成 UNIX 格式
    au FileType php,javascript,html,css,python,vim,vimwiki set ff=unix

    " 保存编辑状态
    au BufWinLeave * if expand('%') != '' && &buftype == '' | mkview | endif
    au BufRead     * if expand('%') != '' && &buftype == '' | silent loadview | syntax on | endif
endif

" =========
" GUI
" =========
if has('gui_running')
    " 只显示菜单
    set guioptions=mcr

    " 高亮光标所在的行
    set cursorline

    if has("win32")
        " Windows 兼容配置
        source $VIMRUNTIME/mswin.vim

        " f11 最大化
        nmap <f11> :call libcallnr('fullscreen.dll', 'ToggleFullScreen', 0)<cr>
        nmap <Leader>ff :call libcallnr('fullscreen.dll', 'ToggleFullScreen', 0)<cr>

        " 自动最大化窗口
        au GUIEnter * simalt ~x

        " 给 Win32 下的 gVim 窗口设置透明度
        au GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 250)

        " 字体配置
        exec 'set guifont='.iconv('Courier_New', &enc, 'gbk').':h10:cANSI'
        exec 'set guifontwide='.iconv('Microsoft\ YaHei', &enc, 'gbk').':h10'
    endif

    " Under Mac
    if has("gui_macvim")
        " MacVim 下的字体配置
        set guifont=Source\ Code\ Pro\ Light:h12
        set guifontwide=微软雅黑:h12

        " 半透明和窗口大小
        set transparency=2
        set lines=40 columns=100

        " 使用 MacVim 原生的全屏幕功能
        let s:lines=&lines
        let s:columns=&columns

        func! FullScreenEnter()
            set lines=999 columns=999
            set fu
        endf

        func! FullScreenLeave()
            let &lines=s:lines
            let &columns=s:columns
            set nofu
        endf

        func! FullScreenToggle()
            if &fullscreen
                call FullScreenLeave()
            else
                call FullScreenEnter()
            endif
        endf

        set guioptions+=e
        " Mac 下，按 <Leader>ff 切换全屏
        nmap <f11> :call FullScreenToggle()<cr>
        nmap <Leader>ff  :call FullScreenToggle()<cr>

        " I like TCSH :^)
        set shell=/bin/tcsh

        " Set input method off
        set imdisable

        " Set QuickTemplatePath
        let g:QuickTemplatePath = $HOME.'/.vim/templates/'

        " 如果为空文件，则自动设置当前目录为桌面
        " lcd ~/Desktop/
    endif

    " Under Linux/Unix etc.
    if has("unix") && !has('gui_macvim')
        set guifont=Courier\ 10\ Pitch\ 11
    endif
endif

" =============
" Key Shortcut
" =============
nmap <C-t>   :tabnew<cr>
nmap <C-p>   :tabprevious<cr>
nmap <C-n>   :tabnext<cr>
nmap <C-k>   :tabclose<cr>
nmap <C-Tab> :tabnext<cr> 

" insert mode shortcut
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-d> <Delete>

"for i in range(1, &tabpagemax)
"    exec 'nmap <A-'.i.'> '.i.'gt'
"endfor

" 插件快捷键
nmap <C-d> :NERDTree<cr>
nmap <C-e> :BufExplorer<cr>
nmap <f2>  :BufExplorer<cr>

" 插入模式按 F4 插入当前时间
imap <f4> <C-r>=GetDateStamp()<cr>

" 新建 XHTML 、PHP、Javascript 文件的快捷键
nmap <C-c><C-h> :NewQuickTemplateTab xhtml<cr>
nmap <C-c><C-p> :NewQuickTemplateTab php<cr>
nmap <C-c><C-j> :NewQuickTemplateTab javascript<cr>
nmap <C-c><C-c> :NewQuickTemplateTab css<cr>
nmap <Leader>ca :Calendar<cr>
nmap <Leader>mr :MRU<cr>
nmap <Leader>dd :NERDTree<cr>
nmap <Leader>bf :BufExplorer<cr>

" 直接查看第一行生效的代码
nmap <Leader>gff :call GotoFirstEffectiveLine()<cr>

" 按下 Q 不进入 Ex 模式，而是退出
nmap Q :x<cr>


" =================
" Plugin Configure
" =================
" Javascript in CheckSyntax
if has('win32')
    let g:checksyntax_cmd_javascript  = 'jsl -conf '.shellescape($VIM . '\vimfiles\plugin\jsl.conf')
else
    let g:checksyntax_cmd_javascript  = 'jsl -conf ~/.vim/plugin/jsl.conf'
endif
let g:checksyntax_cmd_javascript .= ' -nofilelisting -nocontext -nosummary -nologo -process'

" VIM HTML 插件
let g:no_html_toolbar = 'yes'

" Don't display NERDComment Menu.
let g:NERDMenuMode = 0

" VimWiki 配置
if !exists("g:vimwiki_list")
    let g:vimwiki_list = [
                \{"path": "~/Wiki/Android/source/", "path_html": "~/Wiki/Android/",  
                \   "html_footer": "~/Wiki/Android/footer.tpl", "html_header": "~/Wiki/Android/header.tpl",
                \   "auto_export": 1}
                \]
    let g:vimwiki_auto_checkbox = 0
    if has('win32')
        " 注意！
        " 1、如果在 Windows 下，盘符必须大写
        " 2、路径末尾最好加上目录分隔符
        let s:vimwiki_root = "d:/My Documents/My Dropbox/Vimwiki"
        let g:vimwiki_list = [
                    \{"path": s:vimwiki_root."/Default/", 
                    \   "html_footer": s:vimwiki_root."/Default/footer.tpl", 
                    \   "html_header": s:vimwiki_root."/Default/header.tpl",
                    \   "path_html": s:vimwiki_root."/Default/_output/", "auto_export": 1}
                    \]
        let g:vimwiki_w32_dir_enc = 'cp936'
    endif

    au FileType vimwiki set ff=unix fenc=utf8 noswapfile nobackup
    "au FileType vimwiki imap <C-t> <c-r>=TriggerSnippet()<cr>

    nmap <C-i><C-i> :VimwikiTabGoHome<cr>
    nmap <Leader>ii :VimwikiTabGoHome<cr>
endif

" 不要显示 VimWiki 菜单
if has('gui_running')
    let g:vimwiki_menu = ""
endif

" on Windows, default charset is gbk
if has("win32")
    let g:fontsize#encoding = "cp936"
endif

" don't let NERD* plugin add to the menu
let g:NERDMenuMode = 0

" =============
" Color Scheme
" =============
if has('syntax')
    if has('gui_running')
        colorscheme zenburn

        " 默认编辑器配色
        au BufNewFile,BufRead,BufEnter,WinEnter * colo zenburn

        " 各不同类型的文件配色不同
        au BufNewFile,BufRead,BufEnter,WinEnter *.wiki colo lucius
    else 
        colorscheme slate
    endif

    " 保证语法高亮
    syntax on
endif

" vim: set et sw=4 ts=4 sts=4 fdm=marker ft=vim ff=unix fenc=utf8:
