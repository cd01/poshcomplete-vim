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
    call vimproc#system_gui(substitute(s:scriptdir . "\\..\\server\\PoshComplete\\bin\\Release\\PoshComplete.exe", '\\', '\/', 'g'))
    call pyeval('complete("test")') " Initial complete is slow
endfunction

function! poshcomplete#StopServer()
    let cmd = system('powershell -NoProfile -ExecutionPolicy unrestricted -Command "& { kill -name PoshComplete }"')
    echo cmd
endfunction

" vim:set et ts=4 sts=0 sw=4 ff=unix:

