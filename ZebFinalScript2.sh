#!/bin/bash

#"$1" represents the first parameter (the first input video)
#"$2" represents the second parameter (the second input video)
#"$3" represents the background image (such as a stage) (3rd parameter)
#"$4" represents the color of the background in the input videos (the user will could input "chromakey=0x00FF00:0.1" for instance) (4th parameter)

#Make the resolution of both videos to be the same (1280x720)
ffmpeg.exe -i "$1" -s 1280x720 -c:a copy input11.mp4
ffmpeg.exe -i "$2" -s 1280x720 -c:a copy input22.mp4

#Extract the audio track of the first video
ffmpeg.exe -i "$1" Audio.mp3

#Put the videos side by side using hstack
ffmpeg.exe -i input11.mp4 -i input22.mp4 -filter_complex hstack -vsync 0 Composite.mp4

#Remove the background of the video (and make it transparent)
ffmpeg.exe -i Composite.mp4 -vf "$4" -c copy -c:v png Composite2.mov

#Split the composite video into its frames
ffmpeg.exe -i Composite2.mov -r 25 -f image2 %d.png

#Match the resolution of the background image to the composite video
ffmpeg.exe -i "$3" -s 2560x720 -c:a copy Background2.jpg

#Overlay the frames on top of a background image
ffmpeg.exe -i Background2.jpg -i %d.png -filter_complex "overlay" Penultimate.mov

#Add audio back to the video
ffmpeg.exe -i Penultimate.mov -i Audio.mp3 -c copy -map 0:v:0 -map 1:a:0 Final.mov

#Delete the intermediate files
rm input11.mp4
rm input22.mp4
rm Composite.mp4
rm Composite2.mov
rm Background2.jpg
rm Penultimate.mov
rm Audio.mp3
i=1
while [[ "$i" -le 999 ]]
do
  [ -f "$i"".png" ] && rm "$i"".png"
  ((i=i+1))
done
