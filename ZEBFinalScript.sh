#!/bin/bash

#Make the resolution of both videos to be the same (1280x720)
ffmpeg.exe -i input1.mp4 -s 1280x720 -c:a copy input11.mp4
ffmpeg.exe -i input2.mp4 -s 1280x720 -c:a copy input22.mp4

#Put the videos side by side using hstack
ffmpeg.exe -i input11.mp4 -i input22.mp4 -filter_complex hstack -vsync 0 Composite.mp4

#Remove the background of the video (and make it transparent)
ffmpeg.exe -i Composite.mp4 -vf "chromakey=0x00FF00:0.1:0.2" -c copy -c:v png Composite2.mov

#Split the composite video into its frames
ffmpeg.exe -i Composite2.mov -r 25 -f image2 image-%3d.png

#Match the resolution of the background image to the composite video
ffmpeg.exe -i Background.jpg -s 2560x720 -c:a copy Background2.jpg

#Overlay the frames on top of a background image
ffmpeg.exe -i Background2.jpg -i image-%03d.png -filter_complex "overlay" Final.mov

#Delete the intermediate files
