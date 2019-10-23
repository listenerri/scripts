#!/usr/bin/env python3
# coding=utf-8

import ipaddress
import sys

def usage():
    print("invalid arguments")

argv = sys.argv

if len(argv) < 2:
    usage()
    exit(-1)

argv = argv[1:]

for arg in argv:
    if arg.isnumeric():
        print(str(ipaddress.ip_address(int(arg))))
    else:
        print(int(ipaddress.ip_address(arg)))