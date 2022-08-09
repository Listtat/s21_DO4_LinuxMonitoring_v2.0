#!/bin/bash

if [ $# != 0 ]
then
    echo "Invalid number of arguments (should be 0)"
else
    goaccess ../04/*.log --log-format=COMBINED > index.html
fi