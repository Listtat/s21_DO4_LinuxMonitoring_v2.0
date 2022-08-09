#!/bin/bash

function check {
    if [[ ${args} -ne 1 ]]
    then
	    echo "invalid number of arguments"
        exit 1
    fi

    if [[ ${search} -gt 4 || ${search} -lt 1 ]]; then
        echo "Incorrect parameter entered"
        exit 1
    fi

    if [[ $search -eq 1 ]]; then
        search1
    elif [[ $search -eq 2 ]]; then
        search2
    elif [[ $search -eq 3 ]]; then
        search3
    elif [[ $search -eq 4 ]]; then
        search4
    fi
}