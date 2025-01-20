#!/bin/bash

#Remove any existing image#
sudo docker rmi -f react_application 

#docker build command#
sudo docker build -t react_application .

#varify the image#
sudo docker images
