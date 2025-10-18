#!/bin/bash

#
# vscode 在 windows 下使用 cmake + clangd 时会因为盘符大小写导致 clangd 无法正常工作，
# 具体表现如：clangd 的查找引用结果错乱
# 此脚本通过将 cmake 的 compile_commands.json 文件中的所有盘符修改为小写解决此问题
#
# 注：windows 下可通过使用 msys2 执行此脚本
#

set -e

cmake_compile_commands_file="${1}"

if [[ -z "${cmake_compile_commands_file}" ]]; then
    cmake_compile_commands_file="compile_commands.json"
fi

if [[ ! -f "${cmake_compile_commands_file}" ]]; then
    echo "ERROR: cmake compile commands file does not exist: '${cmake_compile_commands_file}'"
    exit 1
fi

sed -i '{s/\(\S:\/\)/\L\1/g; s/\(\S:\\\)/\L\1/g}' "${cmake_compile_commands_file}"

echo "Done"
