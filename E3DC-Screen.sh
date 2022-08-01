#!/bin/ash

echo "run 'screen -x' to attach to the current screen"
echo "use 'CTRL A + D' to detach the current screen"
echo "run 'screen -x -r' to reattach, if prev session was closed without detaching screen"
echo "on Segmentation fault check path and access of logifle (uid 1111/gid 1111)";

# this is never ending
while true
do

    #e3dc-control
    if (screen -list | grep "(Dead ???)" >/dev/null)
    then
        echo "wipe out dead screen"
        screen -wipe
    fi
    # check if screen died and restart it
    if ! (screen -list | grep "E3DC" >/dev/null)
    then
        echo "E3DC-Control starting..."
        ash -c "screen -dmS E3DC ./E3DC.sh"
        echo "E3DC-Control done"
    fi

    # webserver
    if ! (wget --no-verbose --tries=1 --spider http://localhost/index.html)
    then
        echo "lighttpd starting..."
        ash -c "/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf" &
        echo "lighttpd done"
    fi

    sleep 10
done
