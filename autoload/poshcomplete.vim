let s:script_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! poshcomplete#CompleteCommand(findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1

    while start > 0 && (line[start - 1] =~ '\a' || line[start - 1] =~ '-')
      let start -= 1
    endwhile

    return start
  else
    let currentline = getline('.') . a:base
    let res = []

    if currentline == ''
        return []
    endif
    
    let completionwords = eval(system("powershell -NoProfile -ExecutionPolicy unrestricted -Command \"" . fnameescape(s:script_path)  . "\\..\\completions.ps1 '" . currentline . "'\""))

    for completionword in completionwords
      call add(res, completionword)
    endfor

    return res
  endif
endfunction

