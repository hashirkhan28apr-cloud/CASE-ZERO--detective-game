#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
gcc -std=c11 -O2 -Wall -Wextra case_zero.c -o case_zero_console
exec ./case_zero_console
