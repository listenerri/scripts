#!/usr/bin/env bash

# execute command passed to this script in all git repos under current directory
# 在所有当前目录下的 git 仓库中执行传递给这个脚本的命令

Projects=("$(find . -mindepth 1 -maxdepth 1 -type d)")

for pro in ${Projects[*]}; do
    echo "Enter directory: $pro"
    cd "$pro" || exit -1
    if [[ -d .git ]]; then
        echo "execute command: \"$*\""
        command "$@"
    else
        echo "$pro is not a git repo"
    fi
    cd ..
    echo "Leave directory: $pro"
done
