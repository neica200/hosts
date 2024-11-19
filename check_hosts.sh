#!/bin/bash

cat /etc/hosts | while read -r line
do
    if [[ $line == \#* || -z $line ]]
    then
        continue
    fi

    ip=$(echo $line | awk '{print $1}')
    hostname=$(echo $line | awk '{print $2}')

    resolved_ip=$(nslookup $hostname 2>/dev/null | grep -A 1 "Name:" | grep "Address" | tail -n 1 | awk '{print $2}')

    if [[ -z $resolved_ip ]]
    then
        echo "Eroare"
        continue
    fi

    if [[ $resolved_ip != $ip ]]
    then
        echo "Bogus IP for $hostname in /etc/hosts!"
    fi
done