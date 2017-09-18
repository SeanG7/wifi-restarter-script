#!/bin/sh
COUNT=0
FIRSTFAIL=true
while true
do
    if !(ping -q -c 1 -W 1 google.com.au >/dev/null); then
        if $FIRSTFAIL; then
            echo "IPv4 is down"
            networksetup -setairportpower en0 off; networksetup -setairportpower en0 on
            COUNT=$((COUNT + 1))
            echo "Process ID "$$
            echo "Wifi dropped $COUNT times"
            echo
            FIRSTFAIL=false
        fi
    else
        FIRSTFAIL=true
    fi
    trap "echo Exited!; exit;" SIGINT SIGTERM
    sleep 1
done