let s:scriptdir = expand('<sfile>:p:h')

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

        return pyeval('complete(vim.eval("currentline"))')
    endif
endfunction

function! poshcomplete#StartServer()
    let cmd = system(s:scriptdir + "../server/PoshComplete/bin/Release/PoshComplete.exe")
    echo cmd
endfunction

function! poshcomplete#StopServer()
endfunction

" vim:set et ts=4 sts=0 sw=4 ff=unix:

