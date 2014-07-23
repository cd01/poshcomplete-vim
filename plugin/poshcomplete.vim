let s:py_path = join([expand('<sfile>:p:h:h'), "python"], '/')
exec "python sys.path.append(r'" . s:py_path . "')"
exec "pyfile " . fnameescape(s:py_path . '/completion.py')

