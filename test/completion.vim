let g:PoshComplete_Port = "1234"
let s:poshcomplete = themis#suite('poshcomplete')
call themis#helper('command').with(themis#helper('assert'))

set rtp+=.\webapi-vim
set rtp+=.\vimproc
setlocal omnifunc=poshcomplete#CompleteCommand

function! s:poshcomplete.before()
    call poshcomplete#StartServer()
    if exists("$APPVEYOR_BUILD_FOLDER")
        sleep 5
    endif
endfunction

function! s:poshcomplete.after()
    call poshcomplete#StopServer()
endfunction

function! s:poshcomplete.complete_cmdlet()
    %delete
    normal AGet-ChildIt

    let l:actual = getline(1)
    let l:expect = "Get-ChildItem"

    Assert Equals(l:actual, l:expect)
endfunction

function! s:poshcomplete.complete_method()
    %delete
    normal A"string".Lengt

    let l:actual = getline(1)
    let l:expect = '"string".Length'

    Assert Equals(l:actual, l:expect)
endfunction

function! s:poshcomplete.complete_option()
    %delete
    normal AWrite-Host -NoNewlin

    let l:actual = getline(1)
    let l:expect = "Write-Host -NoNewline"

    Assert Equals(l:actual, l:expect)
endfunction

