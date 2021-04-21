#!/bin/bash

if [ $# -eq 0 ]; then
    stream=rtsp://localhost:8080/video.sdp
else
    stream=$1
fi

vlc $stream
