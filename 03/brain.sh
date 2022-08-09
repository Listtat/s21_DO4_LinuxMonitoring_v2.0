#!/bin/bash

function clean1 {
    logs="$(cat ../02/log.txt | awk -F'  ' '{print $1}'))"
    reg='^\/'
    for i in $logs:
    do
        if [[ $i =~ $reg ]]
        then
            sudo rm -rf $i
        fi
    done
}

function clean2 {
    cd ../02
    start_log="$(awk -F' ' '{print $4}' log.txt | sed -n '1p') $(awk -F' ' '{print $5}' log.txt | awk -F':' '{print $1":"$2}' | sed -n '1p')"
    number_last_string="$(wc -l log.txt | awk -F' ' '{print $1}')"
    number_last_string="$(( $number_last_string - 2 ))"
    add_minute="$(sed -n "$number_last_string"p log.txt | awk -F' ' '{print $5}'| awk -F':' '{print $2}')"
    add_minute="$(( $add_minute + 1 ))"
    if [[ $add_minute -lt 10 ]]
    then
        end_log="$(sed -n "$number_last_string"p log.txt | awk -F' ' '{print $4}') $(sed -n "$number_last_string"p log.txt | awk -F' ' '{print $5}'| awk -F':' '{print $1":"}')0$add_minute"
    else
        end_log="$(sed -n "$number_last_string"p log.txt | awk -F' ' '{print $4}') $(sed -n "$number_last_string"p log.txt | awk -F' ' '{print $5}'| awk -F':' '{print $1":"}')$add_minute"
    fi

    echo "Enter the date and time (example: YYYY-MM-DD HH:MM)"
    read -p "Write start date and time: " start
    echo "Enter the date and time (example: YYYY-MM-DD HH:MM)"
    read -p "Write end date and time: " end

    if [[ $start < $start_log ]] || [[ $end > $end_log ]]
    then
        echo "invalid date entered"
        exit 1
    fi

    find / -newermt "$start" ! -newermt "$end" -type f 2>/dev/null | grep $(date +"%d%m%y") | xargs rm -rf
    count_our_dirs=$(find / -name *$(date +"%d%m%y") -type d 2>/dev/null | wc -l)
    
    for (( i=1; i<=$count_our_dirs; i++ ))
    do
        path_of_dir=$(find / -name *$(date +"%d%m%y") -type d | sed -n "$i"p)
        empty_dir=$(ls $path_of_dir | wc -l)
        if [[ $empty_dir -eq 0 ]]
        then
            echo "$path_of_dir" >> /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/03/path_empty_dirs.txt
        fi
    done

    count_str=$(wc -l /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/03/path_empty_dirs.txt | awk '{print $1}')
    while read str
    do
        rm -rf $str 2>/dev/null
    done < /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/03/path_empty_dirs.txt
    rm -rf /home/changeli/DO4_LinuxMonitoring_v2.0-0/src/03/path_empty_dirs.txt
}

function clean3 {
    echo "Write mask for files (example: asda_DDMMYY)"
    read -p "Write mask for files:: " mask
    prefix=$(echo "$mask" | awk -F'_' '{print $1}')

    if [[ $prefix -lt 5 ]]
    then
        count=${#prefix}
        our_mask="$(echo ${prefix:0:1})"
        for (( i=0; i<5-count; i++ ))
        do
            our_mask+="$(echo ${prefix:0:1})"
        done
        our_mask+="$(echo ${prefix:1:${#prefix}})"
        our_mask+="*"
        our_mask+="_"
        our_mask+=$(echo "$mask" | awk -F'_' '{print $2}')
    else
        our_mask=$(echo "$mask" | awk -F'_' '{print $1}')
        our_mask+="*"
        our_mask+="_"
        our_mask+=$(echo "$mask" | awk -F'_' '{print $2}')
    fi
    
    find / -name $our_mask | xargs rm -rf
}
