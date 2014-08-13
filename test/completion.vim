let s:poshcomplete = themis#suite('poshcomplete')
call themis#helper('command').with(themis#helper('assert'))

function! s:poshcomplete.get_childitem()
    set rtp+=.\webapi-vim
    set rtp+=.\vimproc
    setlocal omnifunc=poshcomplete#CompleteCommand
    call poshcomplete#StartServer()

    sleep 10

    %delete
    normal AGet-ChildIt
    normal A
    let current_line = getline(1)

    call poshcomplete#StopServer()

    Assert Equals(current_line, "Get-ChildItem")
endfunction

