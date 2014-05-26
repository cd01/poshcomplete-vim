
function! poshcomplete#py_ext#init(script_path)
python << EOF
import sys, vim
scr_path = vim.eval("a:script_path")
sys.path.insert(0, scr_path)
import getcandidates
sys.path.remove(scr_path)
EOF
endfunction

function! poshcomplete#py_ext#complete(line)
    python getcandidates.complete(vim.eval("a:line"))
    return []
endfunction

" vim:set et ts=4 sts=0 sw=4 ff=unix:
