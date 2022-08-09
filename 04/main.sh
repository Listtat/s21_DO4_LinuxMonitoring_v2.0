#!/bin/bash

date="$(date +%Y)-$(date +%m)-$(date +%d) 00:00:00 $(date +%z)"

if [ $# != 0 ] ; then
    echo "Invalid number of arguments (should be 0)"
    exit 1
else
    seconds=$(shuf -i 10-60 -n1)
    random_number=$(shuf -n1 -i 100-1000)
    for (( i=5; i>0; i-- ))
    do
        for (( j=0; j<random_number; j++ ))
        do
            echo -n "$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255)" >> $i.log
            echo -n " - - " >> $i.log
            echo -n "[$(date -d "$date + $seconds seconds"  +'%d/%b/%Y:%H:%M:%S %z')] " >> $i.log
            echo -n "\"$(shuf -n1 methods) " >> $i.log
            echo -n "$(shuf -n1 urls) " >> $i.log
            echo -n "$(shuf -n1 protocols)\" " >> $i.log
            echo -n "$(shuf -n1 codes)" >> $i.log
            echo -n " \"-\" " >> $i.log
            echo "\"$(shuf -n1 agents)\"" >> $i.log
            ((seconds+=$(shuf -i 10-60 -n1) ))
        done
        date="$(date +%Y)-$(date +%m)-$(date +%d) 00:00:00 $(date +%z)"
        date="$(date -d "$date - $((6-$i)) days" +'%Y-%m-%d')"
    done
fi

# 200 - OK
# 201 - CREATED
# 400 - BAD_REQUEST
# 401 - UNAUTHORIZED
# 403 - FORBIDDEN
# 404 - NOT_FOUND
# 500 - INTERNAL_SERVER_ERROR
# 501 - NOT_IMPLEMENTED
# 502 - BAD_GATEWAY
# 503 - SERVICE_UNAVAILABLE