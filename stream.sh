#!/bin/bash

if ! [ -f "$1" ]; then
    echo "Usage: $0 VIDEO" >&2
    exit 1
fi

echo "Starting HTTP Server"
sleep 2

vlc \
    --sout '#duplicate{dst=gather:http{mux=ffmpeg{mux=flv},dst=:8080/},dst=display}' \
    --no-sout-audio \
    --sout-keep \
    --marq-marquee "Live Camera" \
    --marq-position 8 \
    --marq-size=65 \
    --sub-source marq \
    -L $1 &
vlc_pid=$!

sleep 5

printf "\n\n\n\n"
echo "VLC is running with PID: ${vlc_pid}"
for ip in $(ip a | grep inet | awk '{ print $2 }' | awk -F/ '{ print $1 }'); do
    echo "Server is accessible at http://$ip:8080/"
done

while kill -0 $vlc_pid &> /dev/null; do
    sleep 5
done
