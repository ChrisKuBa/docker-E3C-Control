#!/bin/ash

echo "run 'screen -x' to attach to the current screen"
echo "use 'CTRL A + D' to detach the current screen"
echo "on Segmentation fault check path and access of logifle (uid 1111/gid 1111)";

# this is never ending
while true
do
    # check if screen died and restart it
    if ! (screen -list | grep "E3DC" >/dev/null)
    then
        echo E3DC-Control wird gestartet...
        ash -c "screen -dmS E3DC ./E3DC.sh"
        echo E3DC-Control gestartet.
    fi
    sleep 10
done
