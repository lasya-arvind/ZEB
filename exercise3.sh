#!/bin/sh

#Use ffmpeg to combine 2 videos, but choose the audio from first video to be at a higher volume than the second one
ffmpeg -i spoof-aycd-guide.mp4 -af volume=5 -vcodec copy louder.mp4
ffmpeg -i tiktok.mp4 -af volume=0.2 -vcodec copy quieter.mp4
ffmpeg -i louder.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts louder.ts
ffmpeg -i quieter.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts quieter.ts
ffmpeg -i "concat:louder.ts|quieter.ts" -c copy exercise4.mp4