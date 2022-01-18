import subprocess
import sys
import tempfile
import os
import shlex
import time
import fnmatch

def find(pattern, path):
    result = []
    for root, dirs, files in os.walk(path):
        for name in files:
            if fnmatch.fnmatch(name, pattern):
                result.append(os.path.join(root, name))
    return result

def main(argv):
    jemList = find('*.jemdoc','./')
    for jemdoc in jemList:
        os.system('python jemdoc.py {}'.format(jemdoc))

if __name__ == '__main__':
    main(sys.argv)
