#!/usr/bin/env bash

Action=$1
Fcitx_Cmd=/usr/bin/fcitx-remote
Tmp_File=/tmp/fakevim-fctix.tmp

if [[ ! -f $(file Fcitx_Cmd) ]]; then
    Fcitx_Cmd=/usr/bin/fcitx5-remote
fi

# inactivate fcitx if exec with no args
if [[ -z $Action ]]; then
    # save current state to $Tmp_file
    echo $($Fcitx_Cmd) > $Tmp_File
    $Fcitx_Cmd -c
    exit 0
fi

# restore pre state
if [[ -f $Tmp_File ]]; then
    pre=x"$(cat $Tmp_File)"
    if [[ $pre == x"1" ]]; then
        $Fcitx_Cmd -c
    elif [[ $pre == x"2" ]]; then
        $Fcitx_Cmd -o
    fi
fi
