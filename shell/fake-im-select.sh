#!/usr/bin/env bash

# this script in order to fake the im-select in mac osx for fcitx in linux

IM_EN="com.apple.keylayout.ABC"
IM_CN="2"

FCITX_CMD=/usr/bin/fcitx-remote

# there is no arguments that means query the current im
if [[ -z $@ ]]; then
    if [[ "1" == $($FCITX_CMD) ]]; then
        echo "$IM_EN"
    else
        echo "$IM_CN"
    fi
else
    if [[ "$@" == "$IM_EN" ]]; then
        $FCITX_CMD -c
    elif [[ "$@" == "$IM_CN" ]]; then
        $FCITX_CMD -o
    fi
fi