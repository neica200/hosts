#!/bin/bash

validate_ip_dns() {
    local hostname=$1
    local ip=$2
    local dns_server=$3

    local resolved_ip=$(nslookup $hostname $dns_server 2>/dev/null | grep -A 1 "Name:" | grep "Address" | tail -n 1 | awk '{print $2}')


    if [[ -z $resolved_ip ]]; then
        echo "Eroare: Nu s-a putut rezolva $hostname folosind $dns_server."
        return 1
    fi

    if [[ $resolved_ip != $ip ]]; then
        echo "Bogus IP pentru $hostname! Așteptat: $ip, Rezolvat: $resolved_ip"
        return 1
    fi

    echo "Asocierea dintre $hostname și $ip este validă."
    return 0
}

cat /etc/hosts | while read -r line; do
    if [[ $line == \#* || -z $line ]]; then
        continue
    fi

    ip=$(echo $line | awk '{print $1}')
    hostname=$(echo $line | awk '{print $2}')

    validate_ip_dns $hostname $ip "8.8.8.8"
done
