#!./bin/bash
#Exercise 4: Use ffmpeg to combine 2 videos side-by-side at 50% each on the x-axis (rectangles are left and right)

ffmpeg -i music.mp4 -i pizza.mp4 -filter_complex "
nullsrc=size=1000x500 [background];
[0:v] setpts=PTS-STARTPTS, scale=500x500 [left];
[1:v] setpts=PTS-STARTPTS, scale=500x500 [right];
[background][left]overlay=shortest=1 [background+left];
[background+left][right] overlay=shortest=1:x=500
" output11.mp4
