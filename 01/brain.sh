#!/bin/bash

function create_names_for_dirs {
    touch log.txt
    for (( number=0; number <$count_dirs; number++ ))
    do
        dir_name=""
        if [[ ${#letters_dirs} -lt 4 ]]
        then
            create_dir_with_little_name
            create_files
        else
            create_dir_with_big_name
            create_files
        fi
    done
}

function create_dir_with_little_name {
    count=${#letters_dirs}
    for (( i=0; i<5-count; i++ ))
    do
        dir_name+="$(echo ${letters_dirs:0:1})"
    done
    dir_name+="$(echo ${letters_dirs:1:${#letters_dirs}})"
    dir_name+=$number
    dir_name+="_"
    dir_name+=$(date +"%d%m%y")
    mkdir $dir_name
    echo $path"/"$dir_name --- $(date +'%e.%m.%Y') ---  >> log.txt
}

function create_dir_with_big_name {
    dir_name=$letters_dirs
    dir_name+=$number
    dir_name+="_"
    dir_name+=$(date +"%d%m%y")
    mkdir $dir_name
    echo $path"/"$dir_name --- $(date +'%e.%m.%Y') ---  >> log.txt
}

function create_files {
    file_name_start="$(echo $letters_files | awk -F "." '{print $1}')"
    file_name_end="$(echo $letters_files | awk -F "." '{print $2}')"
    for (( number_files=0; number_files <$count_files; number_files++ ))
    do
        file_name=""
        if [[ ${#file_name_start} -lt 4 ]]
        then
            create_files_with_little_name
            echo $path"/"$dir_name"/"$file_name --- $(date +'%e.%m.%Y') --- $size "Kb" >> log.txt
        else
            create_files_with_big_name
            echo $path"/"$dir_name"/"$file_name --- $(date +'%e.%m.%Y') --- $size "Kb" >> log.txt
        fi
    done
}

function create_files_with_little_name {
    count=${#file_name_start}
    for (( i=0; i<5-count; i++ ))
    do
        file_name+="$(echo ${file_name_start:0:1})"
    done
    file_name+="$(echo ${file_name_start:1:${#file_name_start}})"
    file_name+=$number_files
    file_name+="_"
    file_name+=$(date +"%d%m%y")
    file_name+="."
    file_name+=$file_name_end
    fallocate -l $size"KB" ./$dir_name/$file_name

    if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
    then
        exit 1
    fi
}

function create_files_with_big_name {
    file_name+="$(echo ${file_name_start:0:${#file_name_start}})"
    file_name+=$number_files
    file_name+="_"
    file_name+=$(date +"%d%m%y")
    file_name+="."
    file_name+=$file_name_end
    fallocate -l $size"KB" ./$dir_name/$file_name
    if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
    then
        exit 1
    fi
}