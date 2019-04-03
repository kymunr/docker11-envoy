#
# Nightwatch.js Dockerfile
#

FROM node:latest

ENV APP_DIR /nightwatch

# Node.js setup

RUN apt-get install -y \
  curl \
  python \
  git \
  libstdc++

# Copied from https://github.com/sgerrand/alpine-pkg-glibc
# Need to run BrowserStack
#RUN apt-get add ca-certificates wget
#RUN wget -q -O  /etc/apt-get/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
#RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apt-get
#RUN apt-get add glibc-2.28-r0.apt-get
#
#RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-bin-2.28-r0.apt-get
#RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-i18n-2.28-r0.apt-get
#RUN apt-get add glibc-bin-2.28-r0.apt-get glibc-i18n-2.28-r0.apt-get
#RUN /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8

RUN wget https://www.browserstack.com/browserstack-local/BrowserStackLocal-linux-x64.zip \
    && unzip BrowserStackLocal-linux-x64.zip \
    && chmod +x BrowserStackLocal \
    && mv BrowserStackLocal /usr/local/bin \
    && rm BrowserStackLocal-linux-x64.zip

# Change working directory
WORKDIR $APP_DIR
COPY . $APP_DIR

# Nightwatch
#RUN npm ci

# Run Tests
#CMD npm run remote

