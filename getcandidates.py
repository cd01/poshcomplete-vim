from subprocess import Popen, PIPE
import vim
import os.path


def complete(arg):
    p = Popen([os.path.join(os.path.dirname(__file__), "PoshComplete",
               "PoshComplete", "bin", "Release", "PoshComplete.exe"),
               "'" + arg + "'"],
              stdout=PIPE,
              shell=True)
    while True:
        line = p.stdout.readline()
        if not line:
            break
        print line[:-2]
        if vim.eval("complete_check()") != "0":
            p.stdout.close()
            p.kill()
            return
        try:
            vim.eval("complete_add(" + line[:-2] + ")")
        except vim.error:
            pass
    p.wait()
