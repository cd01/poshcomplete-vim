from subprocess import Popen, PIPE
import vim
import os.path


def complete(arg):
    p = Popen(["powershell.exe", "-NoLogo", "-NoProfile", "-NonInteractive",
               "-ExecutionPolicy", "RemoteSigned",
               "-Command", os.path.dirname(__file__) + "\completions.ps1 '" + arg + "'"],
              stdout=PIPE,
              shell=True)
    while 1:
        line = p.stdout.readline()
        if not line:
            break
        if vim.eval("complete_check()") != "0":
            p.stdout.close()
            p.kill()
            return
        try:
            vim.eval("complete_add(" + line[:-1] + ")")
        except vim.error:
            pass
    p.wait()
