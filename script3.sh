#!./bin/bash
#Exercise 1: Use ffmpeg to extract images from a video (example 10)

ffmpeg -i pizza.mp4 -r 1 -f image2 image-%2d.png