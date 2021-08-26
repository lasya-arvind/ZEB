#!/bin/bash

#Make the resolution of both videos to be the same (1280x720)
ffmpeg -i input1.mp4 -s 1280x720 -c:a copy input11.mp4
ffmpeg -i input2.mp4 -s 1280x720 -c:a copy input22.mp4

#Put the videos side by side using hstack
ffmpeg -i input11.mp4 -i input22.mp4 -filter_complex hstack -vsync 0 Composite.mp4

#Remove the background of the video (and make it transparent)
ffmpeg -i Composite.mp4 -vf "chromakey=0x00FF00:0.1:0.2" -c copy -c:v png Composite2.mov

#Split the composite video into its frames
ffmpeg -i Composite2.mov -r 25 -f image2 image-%3d.png

#Overlay the frames on top of a background image
ffmpeg -i Background.png -i image-%03d.png -filter_complex "overlay" Final.mov

#Delete the intermediate files
