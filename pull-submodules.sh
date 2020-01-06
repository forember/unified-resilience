#!/bin/sh
set -e
set -x
cd "$(dirname "$0")"
git pull
git submodule sync --recursive
git submodule update --recursive --init
git submodule foreach --recursive git checkout master
git submodule foreach --recursive git pull
