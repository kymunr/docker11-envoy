#
# Nightwatch.js Dockerfile
#

FROM node:11-alpine

ENV APP_DIR /nightwatch

# Node.js setup
RUN apk --no-cache add \
  curl \
  graphicsmagick \
  python \
  git \
  libstdc++

RUN ln -s /usr/bin/python2.7 /usr/bin/python

# Copied from https://github.com/sgerrand/alpine-pkg-glibc
# Need to run BrowserStack
RUN apk --no-cache add ca-certificates wget
RUN wget -q -O  /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk
RUN apk add glibc-2.28-r0.apk

RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-bin-2.28-r0.apk
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-i18n-2.28-r0.apk
RUN apk add glibc-bin-2.28-r0.apk glibc-i18n-2.28-r0.apk
RUN /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8

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
