#!/bin/bash

# start selenium behind xvfb
DISPLAY=:1 xvfb-run --server-args="-screen 0 1024x768x24 +extension RANDR" /usr/bin/java -jar /opt/selenium/selenium-server-standalone.jar &
