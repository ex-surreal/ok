#!/usr/bin/python

import os, shlex
from subprocess import call, check_output, STDOUT
import argparse

def run_file(name):
    if name != '' and os.path.exists(name) and os.path.isfile(name):
        filename, ext = os.path.splitext(name)
        command = ''
        remove_binary = ''
        if ext in ['.cpp', '.cc', '.c++', '.h', '.hpp']:
            compile_command = 'g++ --std=c++11 -Wall -o {0}.o {1}'.format(
                filename, name
            )
            compile_command = shlex.split(compile_command)
            if call(compile_command) != 0:
                exit()
            command = os.path.abspath('{0}.o'.format(filename))
            remove_binary = os.path.abspath('{0}.o'.format(filename))
        elif ext in ['.c']:
            compile_command = 'gcc -Wall -o {0}.o {1}'.format(
                filename, name
            )
            compile_command = shlex.split(compile_command)
            if call(compile_command) != 0:
                exit()
            command = os.path.abspath('{0}.o'.format(filename))
            remove_binary = os.path.abspath('{0}.o'.format(filename))
        elif ext in ['.py']:
            command = 'python {}'.format(name)
        else:
            exit('No support for {}'.format(ext))
        command = shlex.split(command)
        try:
            f = call(command) 
            if remove_binary != '':
                call(['rm', remove_binary])
            if f != 0:
                exit('Segmentation Fault')
        except KeyboardInterrupt:
            pass
    else:
        exit('{}: No such name'.format(name))

resources = '{}/.ok/resources'.format(os.path.expanduser('~'))

def get_template(ext, flag):
    if flag:
        return ''
    template = ''
    if ext in ['.cpp', '.cc', '.c++']:
        template_file = '{}/template.cpp'.format(resources);
        if os.path.exists(template_file):
            with open(template_file) as f:
                template = f.read()
            f.close()
    return template

def open_file(name, editor, without_template):
    if not os.path.exists(name):
        template = get_template(os.path.splitext(name)[-1], without_template)
        with open(name, 'w') as f:
            f.write(template)
        f.close()
    command = '{} {}'.format(editor, name)
    command = shlex.split(command)
    call(command)

def parse_args():
    parser = argparse.ArgumentParser(prog='ok', version='1.0')

    parser.add_argument('file', help='File name to process')
    parser.add_argument(
        '-o', '--open',
        action='store_true',
        help='Open a file to edit'
    )
    parser.add_argument(
        '-t', '--without-template',
        action='store_true',
        help='Open file without template'
    )
    parser.add_argument(
        '-e', '--editor',
        default='vim',
        help='Specify editor to open with'
    )
    return parser.parse_args()

def main():
    args = parse_args()
    if args.open:
        open_file(args.file, args.editor, args.without_template)
    else:
        run_file(args.file)

if __name__ == '__main__':
    main()
