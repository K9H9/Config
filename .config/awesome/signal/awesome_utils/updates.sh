#!/bin/sh

count=$(checkupdates | wc -l)
if [[ $count == 0 ]]; then
    echo "No updates"
else
    echo "$count Updates available"
fi