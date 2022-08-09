#!/bin/bash

if [ $# != 0 ] ; then
    echo "error"
    exit 1
else
    while true; do
        if [[ -f data.html ]]; then
            rm data.html
        fi
        CPU="$(cat /proc/loadavg | awk '{print $1}')"
        Disk_Space="$(df /| grep / | awk '{print $2}')"
        Disk_Space_Used="$(df /| grep / | awk '{print $3}')"
        Memory="$(free | grep Mem | awk '{print $2}')"
        Memory_Used="$(free | grep Mem | awk '{print $3}')"
        echo "# HELP cpu Take Cpu" >> data.html
        echo "# TYPE cpu gauge" >> data.html
        echo "cpu $CPU" >> data.html
        echo "# HELP disk_space Take Disk_Space" >> data.html
        echo "# TYPE disk_space gauge" >> data.html
        echo "disk_space $Disk_Space" >> data.html
        echo "# HELP disk_space_used Take Disk_Space_Used" >> data.html
        echo "# TYPE disk_space_used gauge" >> data.html
        echo "disk_space_used $Disk_Space_Used" >> data.html
        echo "# HELP memory Take Memory" >> data.html
        echo "# TYPE memory" >> data.html
        echo "memory $Memory" >> data.html
        echo "# HELP memory Take Memory_Used" >> data.html
        echo "# TYPE memory_used" >> data.html
        echo "memory_used $Memory_Used" >> data.html
        sleep 3
    done
fi