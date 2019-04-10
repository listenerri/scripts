#!/usr/bin/env bash

current_dir="$(pwd)"

if [[ ! -d "${current_dir}/.git" ]]; then
    echo "Current dir: ${current_dir} is not a git repo"
    exit 1
fi

echo "Current git repo dir is: ${current_dir}"

is_master="$(git branch | grep '\* master')"
if [[ -n "${is_master}" ]]; then
    echo "Checkout to branch: changelog"
    git checkout -b changelog || exit 2
else
    echo "Current branch is not master"
    exit 3
fi

echo "The older tags is:"
git tag | sort -V | tail

read -rp "input the new tag: " dest_tag

echo "Update CHANGELOG.md file using tag: ${dest_tag}"
if [[ -f CHANGELOG.md ]]; then
    echo "Not find CHANGELOG.md file" || exit 4
fi
clog -C CHANGELOG.md -F --setversion "${dest_tag}" || exit 5

echo "The changes of CHANGELOG.md file is:"
git diff master

read -rp "Continue to add and commit changes?(Y/n) " continue

if [[ ! "x${continue}" = x && ! "x${continue}" = xY && ! "x${continue}" = xy ]]; then
    echo "Abort"
    exit 6
fi

echo "Add and commit these changes"
git add CHANGELOG.md || exit 7
git commit -m "update changelog ${dest_tag}"

echo "Push to remote ri"
git push ri || exit 8

echo "Checkout to master and delete branch changelog"
git checkout master
git branch -D changelog
git branch -D -r ri/changelog
