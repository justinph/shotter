 #!/bin/sh

# start selenium behind xvfb
echo "Starting Selenium"
DISPLAY=:1 xvfb-run --server-args="-screen 0 1024x768x24 +extension RANDR" /usr/bin/java -jar /opt/selenium/selenium-server-standalone.jar &

sleep 3

echo "Starting Node"
/usr/bin/node /app/shoot.js
