" TODO: convert from return string to dictionary is very slow? (use if_lua?

let s:script_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! poshcomplete#CompleteCommand(findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1

    while start > 0 && (line[start - 1] =~ '\a' || line[start - 1] =~ '-') " TODO: hyphen only?
      let start -= 1
    endwhile

    return start
  else
    let res = []
    let completionwords = eval(system("powershell -Command \"" . fnameescape(s:script_path)  . "\\..\\completions.ps1\" \"" . a:base . "\""))

    for completionword in completionwords
      call add(res, completionword)
    endfor

    return res
  endif
endfunction
