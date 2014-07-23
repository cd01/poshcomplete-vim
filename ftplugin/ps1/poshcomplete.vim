" if !exists('g:PoshComplete_Port')
"     let g:PoshComplete_Port='1234'
" endif

setlocal omnifunc=poshcomplete#CompleteCommand

augroup poshcomplete
    autocmd! * <buffer>
	autocmd BufNewFile,BufRead * call poshcomplete#StartServer()
    autocmd BufLeave <buffer> call poshcomplete#StopServer()
augroup END

