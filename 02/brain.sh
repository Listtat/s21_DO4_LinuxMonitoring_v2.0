#!/bin/bash

function start {
    touch log.txt
    START=$(date +'%s%N')
    START_TIME=$(date +'%Y-%m-%d %H:%M:%S')
    echo "Script started at $START_TIME" > log.txt
    echo "Script started at $START_TIME"
    count_dirs=$(echo $(( 1 + $RANDOM % 100 )))
    do_not_enter='\/[s]?bin'
    for (( number=0; number<$count_dirs; number++ ))
    do
        cd /
        path="/"
        dir_name=""
        create_dir
    done
    stop_script
}

function create_dir {
    count_dirs_in_current_dir=$(echo $(ls -l -d */ 2>/dev/null | wc -l ))

    if [[ $count_dirs_in_current_dir -eq 0 ]]
    then
        random_number=0
    else
        random_number=$(echo $(( $RANDOM % $count_dirs_in_current_dir )))
    fi

    if [[ $random_number -eq 0 ]]
    then
        if [[ ${#letters_dirs} -lt 5 ]]
        then
            create_dir_with_little_name
        else
            create_dir_with_big_name
        fi
        sudo mkdir $path$dir_name 2>/home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/error.txt
        if ! [[ -s /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/error.txt ]]
        then
            echo $path$dir_name --- $(date +'%Y-%m-%d %H:%M:%S') --- >> /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/log.txt
            create_files
        fi
    else
        path+="$( ls -l -d */ | awk '{print $9}' | sed -n "$random_number"p )"
        if ! [[ $path =~ $do_not_enter ]]
        then
            cd $path
            create_dir
        fi
    fi
}

function create_dir_with_little_name {
    count=${#letters_dirs}
    for (( i=0; i<6-count; i++ ))
    do
        dir_name+="$(echo ${letters_dirs:0:1})"
    done
    dir_name+="$(echo ${letters_dirs:1:${#letters_dirs}})"
    dir_name+=$number
    dir_name+="_"
    dir_name+=$(date +"%d%m%y")
}

function create_dir_with_big_name {
    dir_name=$letters_dirs
    dir_name+=$number
    dir_name+="_"
    dir_name+=$(date +"%d%m%y")
}

function create_files {
    file_name_start="$(echo $letters_files | awk -F "." '{print $1}')"
    file_name_end="$(echo $letters_files | awk -F "." '{print $2}')"
    count_files=$(echo $(( $RANDOM % 1000 )))
    for (( number_files=0; number_files <$count_files; number_files++ ))
    do
        file_name=""
        if [[ ${#file_name_start} -lt 5 ]]
        then
            if ! [[ -s /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/error1.txt ]]
            then
                create_files_with_little_name
                echo $path$dir_name"/"$file_name --- $(date +'%Y-%m-%d %H:%M:%S') --- $size "Mb" >> /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/log.txt
            else
                rm -rf /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/error1.txt
                break
            fi
        else
            if ! [[ -s /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/error1.txt ]]
            then
                create_files_with_big_name
                echo $path$dir_name"/"$file_name --- $(date +'%Y-%m-%d %H:%M:%S') --- $size "Mb" >> /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/log.txt
            else
                rm -rf /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/error1.txt
                break
            fi
        fi
    done
}

function create_files_with_little_name {
    count=${#file_name_start}
    for (( i=0; i<6-count; i++ ))
    do
        file_name+="$(echo ${file_name_start:0:1})"
    done
    file_name+="$(echo ${file_name_start:1:${#file_name_start}})"
    file_name+=$number_files
    file_name+="_"
    file_name+=$(date +"%d%m%y")
    file_name+="."
    file_name+=$file_name_end
    sudo fallocate -l $size"MB" $path/$dir_name/$file_name 2>/home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/error1.txt
    if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
    then
        stop_script
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
    if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
    then
        stop_script
        exit 1
    fi
}

function stop_script {
    rm -rf /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/error.txt
    rm -rf /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/error1.txt
    END=$(date +'%s%N')
    END_TIME=$(date +'%Y-%m-%d %H:%M:%S')
    echo "Script finished at $END_TIME" >> /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/log.txt
    echo "Script finished at $END_TIME"
    DIFF=$((( $END - $START ) / 100000000 ))
    echo "Script execution time (in seconds) = $(( $DIFF / 10 )).$(( $DIFF % 10 ))" >> /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/log.txt
    echo "Script execution time (in seconds) = $(( $DIFF / 10 )).$(( $DIFF % 10 ))"
    echo -e "" >> /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/02/log.txt
}
