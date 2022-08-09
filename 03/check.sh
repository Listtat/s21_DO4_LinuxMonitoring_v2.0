#!/bin/bash

function check {
    if [[ ${count_var} -ne 1 ]]
    then
        echo "invalid number of arguments"
        exit 1
    fi

    if [[ ${option} -gt 3 || ${option} -lt 1 ]]
    then
        echo "Incorrect parameter entered"
        exit 1
    fi

    if [[ $option -eq 1 ]]; then
        clean1
    elif [[ $option -eq 2 ]]; then
        clean2
    elif [[ $option -eq 3 ]]; then
        clean3
    fi
}