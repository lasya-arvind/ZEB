#!/bin/bash

#"$1" represents the first parameter (the first input video)
#"$2" represents the second parameter (the second input video)
#"$3" represents the background image (such as a stage) (3rd parameter)
#"$4" represents the color of the background in the input videos (has to be an RGB hex value) (4th parameter)
#Make the resolution of both videos to be the same (1280x720)
ffmpeg -i "$1" -s 1280x720 -c:a copy input11.mp4
ffmpeg -i "$2" -s 1280x720 -c:a copy input22.mp4

#Put the videos side by side using hstack
ffmpeg -i input11.mp4 -i input22.mp4 -filter_complex hstack -vsync 0 Composite.mp4

#Remove the background of the video (and make it transparent)
ffmpeg -i Composite.mp4 -vf "chromakey=0x" "$4" -c copy -c:v png Composite2.mov

#Split the composite video into its frames
ffmpeg -i Composite2.mov -r 25 -f image2 image-%3d.png

#Match the resolution of the background image to the composite video
ffmpeg -i "$3" -s 2560x720 -c:a copy Background2.jpg

#Overlay the frames on top of a background image
ffmpeg -i Background2.jpg -i image-%03d.png -filter_complex "overlay" Final.mov

#Delete the intermediate files
