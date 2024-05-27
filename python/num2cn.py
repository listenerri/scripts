#!/usr/bin/env python3
# coding = utf-8
# author = listenerri
# maintainer = listenerri

import cn2an
import sys

if len(sys.argv) < 2:
    print("Need specify a number as argument")
    exit(255)

print(cn2an.an2cn(sys.argv[1], "up"))
