#!/usr/bin/env python
from requests import Session
import os
import sys


def create_fifo():
    ""

    path = "/tmp/my_program.fifo"
    if isfile(path) == False:
        open(path, 'a').close()
    fifo = open(path, 'r+')

    return fifo


def turn_off(session, address):
    ""
    r = session.get(address, headers={'x-test2': 'true'})
    print(r.content)
    return True


def main():
    ""
    adr = ''
    usr = ''
    pw = ''

    f = create_fifo()
    while True:
        for line in fifo:
            print("Received: " + line)
    f.close()

    s = requests.Session()
    s.auth = (usr, pw)
    s.headers.update({'x-test': 'true'})
    turn_off(s)


if __name__ == '__main__':
    main()
