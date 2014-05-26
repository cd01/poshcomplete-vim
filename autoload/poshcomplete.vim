let s:script_path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

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
        let res = []

        if currentline == ''
            return []
        endif

        let completionwords = eval(system("powershell -NoProfile -ExecutionPolicy unrestricted -Command \"" . fnameescape(s:script_path)  . "\\completions.ps1 '" . currentline . "'\""))

        for completionword in completionwords
            call add(res, completionword)
        endfor

        return res
    endif
endfunction

" vim:set et ts=4 sts=0 sw=4 ff=unix:

