#!/bin/bash

#Deploy the image to container#
sudo docker run -dit -p 80:80 --name satthya react_application

#confirm the running container#
sudo docker ps -a


