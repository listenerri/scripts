#!/usr/bin/env bash

# this script is a implemention of im-select cmd on linux with fcitx

IM_EN="1"
IM_CN="2"

FCITX_CMD=/usr/bin/fcitx-remote

if [[ ! -f $(file FCITX_CMD) ]]; then
    FCITX_CMD=/usr/bin/fcitx5-remote
fi

# there is no arguments that means query the current im
if [[ -z $@ ]]; then
    echo "$($FCITX_CMD)"
else
    if [[ "$@" == "$IM_EN" ]]; then
        $FCITX_CMD -c
    elif [[ "$@" == "$IM_CN" ]]; then
        $FCITX_CMD -o
    fi
fi
