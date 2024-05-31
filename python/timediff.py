#!/usr/bin/env python3
# coding = utf-8
# author = listenerri
# maintainer = listenerri

import sys
from datetime import datetime


if len(sys.argv) != 3:
    print("Need specify two ISO format date time as arguments")
    print("timediff.py <smaller time> <larger time>")
    exit(255)

tLeft = datetime.fromisoformat(sys.argv[1])
tRight = datetime.fromisoformat(sys.argv[2])

print("diff in total seconds: {}".format((tRight - tLeft).total_seconds()))

