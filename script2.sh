#!./bin/bash
#Exercise 3: Use ffmpeg to combine 2 videos 

ffmpeg -f concat -safe 0 -i mylist.txt -c copy output.mp4 