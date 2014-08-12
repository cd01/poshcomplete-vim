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
        let res = webapi#http#get("http://localhost:1234/poshcomplete/" . currentline, {}, {}, s:noproxy_option)

        return webapi#json#decode(res.content)
    endif
endfunction

function! poshcomplete#StartServer()
    echo substitute(s:scriptdir . "\\..\\server\\PoshComplete\\bin\\Release\\PoshComplete.exe", '\\', '\/', 'g')
    call vimproc#system_gui(substitute(s:scriptdir . "\\..\\server\\PoshComplete\\bin\\Release\\PoshComplete.exe", '\\', '\/', 'g'))
    let res = webapi#http#get("http://localhost:1234/poshcomplete/test", {}, {}, '--no-proxy')
endfunction

function! poshcomplete#StopServer()
    call webapi#http#get("http://localhost:1234/stop", {}, {}, '--no-proxy')
endfunction

" vim:set et ts=4 sts=0 sw=4 ff=unix:

