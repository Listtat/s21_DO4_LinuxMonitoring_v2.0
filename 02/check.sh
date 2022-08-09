#!/bin/bash

function check {
    if [[ $count_var -ne 3 ]]
    then
        echo "invalid number of arguments"
        exit 1
    fi

    reg='^[a-zA-Z]{1,7}$'
    if ! [[ $letters_dirs =~ $reg ]]
    then
        echo "incorrect name for folders"
        exit 1
    fi

    reg='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
    if ! [[ $letters_files =~ $reg ]]
    then
        echo "incorrect name for files"
        exit 1
    fi

    reg='^[1-9][0-9]?[0]?Mb$'
    if ! [[ $size =~ $reg ]]
    then
        echo "incorrect size"
        exit 1
    else
        size=$(echo $size | awk -F"Mb" '{print $1}')
    fi
}