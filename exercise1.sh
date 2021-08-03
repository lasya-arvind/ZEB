#!/bin/sh

#Use ffmpeg to extract images from a video
ffmpeg -i spoof-aycd-guide.mp4 -r 1 -f image2 image-%2d.png