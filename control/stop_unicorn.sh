#!/bin/bash

cat /home/pi/control/tmp/pids/unicorn.pid | xargs kill -QUIT
