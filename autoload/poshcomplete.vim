let s:scriptdir = expand('<sfile>:p:h')

if executable('curl')
    let s:noproxy_option = '--noproxy'
elseif executable('wget')
    let s:noproxy_option = '--no-proxy'
else
    let s:noproxy_option = 1
endif


function! poshcomplete#CompleteCommand(findstart, base)
    if a:findstart
        let line = getline('.')
        let start = col('.') - 1

        while (start > 0 && line[start - 1] =~ '[[:alpha:]$]' || line[start - 1] =~ '-')
            let start -= 1
        endwhile

        return start
    else
        let baseword = (a:base == '0') ? '-' : a:base " Bacause dash is replaced by zero
        let currentline = getline('.') . baseword

        if currentline == ''
            return []
        endif

        " TODO: change to post method better??
        let res = webapi#http#get("http://localhost:" . g:PoshComplete_Port . "/poshcomplete/" . currentline, {}, {}, s:noproxy_option)

        return webapi#json#decode(res.content)
    endif
endfunction

function! poshcomplete#StartServer()
    let is_vimproc = 0
    silent! let is_vimproc = vimproc#version()

    if is_vimproc
        call vimproc#system_gui("powershell -NoProfile -ExecutionPolicy unrestricted -Command 'Start-Process " . s:scriptdir . "\\..\\server\\PoshComplete\\bin\\Release\\PoshComplete.exe -ArgumentList \"-p " . g:PoshComplete_Port . "\" -WindowStyle Hidden'")
    else
        echo "Please install vimproc"
    endif

    let res = webapi#http#get("http://localhost:" . g:PoshComplete_Port . "/poshcomplete/test", {}, {}, '--no-proxy')
endfunction

function! poshcomplete#StopServer()
    call webapi#http#get("http://localhost:" . g:PoshComplete_Port . "/stop", {}, {}, '--no-proxy')
endfunction

" vim:set et ts=4 sts=0 sw=4 ff=unix:

