FROM node:11-stretch-slim as build

WORKDIR /build
RUN apt-get update && apt-get install -y imagemagick wget
ENV HUGO_VERSION 0.58.0
ENV HUGO_ARCHIVE hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN set -x && \
  wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ARCHIVE} && \
  tar xzf ${HUGO_ARCHIVE} && \
  mv hugo /usr/bin
COPY package.json package-lock.json /build/
RUN npm ci
COPY . .
RUN npm run build && /usr/bin/hugo version && /usr/bin/hugo

FROM nginx:alpine

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /build/public /var/www
