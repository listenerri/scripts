#!/bin/bash

# run this script under where you want place the downloaded printers dir

set -e

wget https://invent.kde.org/kdevelop/kdevelop/-/archive/master/kdevelop-master.tar.gz
tar xf kdevelop-master.tar.gz
rm -rf ./printers
mv kdevelop-master/plugins/gdb/printers ./

