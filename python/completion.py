import vim
import os.path
import urllib
import json


def complete(arg):
    json_text = urllib.urlopen("http://localhost:1234/poshcomplete/" + arg).read()
    return json.loads(json_text)

