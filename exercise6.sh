#!/bin/sh

#Use ffmpeg to combine 1 video with 1 audio stream (any audio stream)
ffmpeg -i spoof-aycd-guide.mp4 -i tiktok.mp4 -map 0:0 -map 1:1 merge.mp4
#another way to do it
ffmpeg -i spoof-aycd-guide.mp4 -i "Calvin Harris - Summer (Audio).mp3" -c:v copy -c:a aac -map 0:v -map 1:a merge.mp4