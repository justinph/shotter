
FROM ubuntu:xenial

# update packages list, install wget, CHECKS OK
RUN apt-get update -qqy && \
    apt-get -qqy install wget ca-certificates apt-transport-https && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# installing chrome is a bit complicated, borrowed from:
# https://github.com/yukinying/chrome-headless-browser-docker/blob/master/chrome/Dockerfile
# CHECKS OK
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -y install google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install Java, CHECKS OK
RUN apt-get -y --no-install-recommends install openjdk-8-jre-headless

# download selenium sever, CHECKS OK
RUN  mkdir -p /opt/selenium \
  && wget --no-verbose https://selenium-release.storage.googleapis.com/3.4/selenium-server-standalone-3.4.0.jar -O /opt/selenium/selenium-server-standalone.jar

# install chromedriver, CHECKS OK
RUN apt-get install unzip && \
    wget https://chromedriver.storage.googleapis.com/2.30/chromedriver_linux64.zip -q && \
    unzip chromedriver_linux64.zip && \
    chmod +x chromedriver && \
    mv -f chromedriver /usr/local/share/chromedriver && \
    ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver && \
    ln -s /usr/local/share/chromedriver /usr/bin/chromedriver

# flash, CHECKS OK
RUN apt-get install -y --no-install-recommends pepperflashplugin-nonfree

# CHECKS OK
RUN apt-get install -y xvfb graphicsmagick

# need fonts for decent rendering, CHECKS OK
RUN apt-get install -y xfonts-100dpi xfonts-75dpi xfonts-base xfonts-cyrillic xfonts-encodings xfonts-scalable xfonts-terminus xfonts-utils

# next three install MS core fonts, e.g. arial, georgia, CHECKS OK
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN apt-get install ttf-mscorefonts-installer

# clean font cache, CHECKS OK
RUN /usr/bin/fc-cache -f -v

# Need to research the correct thing to do here
# see: https://www.ctl.io/developers/blog/post/dockerfile-entrypoint-vs-cmd/
# TODO: install node,

CMD ["/bin/bash"]





