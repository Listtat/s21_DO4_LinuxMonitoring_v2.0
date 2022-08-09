#!/bin/bash
. ./check.sh
. ./brain.sh

export count_var=${#}
export letters_dirs=${1}
export letters_files=${2}
export size=${3}

check
start