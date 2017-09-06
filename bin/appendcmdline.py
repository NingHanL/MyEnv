#!/usr/bin/env python

import os
import sys
import shutil
import subprocess

append_context = sys.argv[1]
grub_conf = '/etc/default/grub'
grub_conf_bk = '/etc/default/grub.bk'

if not os.path.isfile(grub_conf):
    print('grub config file not found.')
    sys.exit(1)

shutil.copyfile(grub_conf, grub_conf_bk)

if not os.path.isfile(grub_conf_bk):
    print('fail to backup grub config file.')
    sys.exit(1)

with open(grub_conf_bk, 'r') as fb:
    with open(grub_conf, 'w') as f:
        for lb in fb:
            if lb.startswith('GRUB_CMDLINE_LINUX_DEFAULT'):
                name, context = lb.split('=', 1)
                new_context = ' '.join([context.strip()[1:-1], append_context])
                newline = '='.join([name, '"' + new_context + '"']) + '\n'
                f.write(newline)
                continue
            f.write(lb)

subprocess.run('grub-mkconfig -o /boot/grub/grub.cfg'.split(' '))
