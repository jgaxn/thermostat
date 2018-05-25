#!/bin/bash

gpio mode 0 output
gpio mode 1 output
gpio write 0 1
gpio write 1 1
cd /home/pi/control && unicorn -c /home/pi/control/unicorn.rb -E development -D

