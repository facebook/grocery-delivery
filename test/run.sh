#!/usr/bin/env bash
set -o verbose
set -e
./test/run-svn.sh
./test/run-git.sh
