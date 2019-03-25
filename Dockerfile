FROM node:alpine as build

WORKDIR /build
ENV HUGO_VERSION 0.41
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN set -x && \
  apk add --update wget ca-certificates imagemagick && \
  wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
  tar xzf ${HUGO_BINARY} && \
  mv hugo /usr/bin
COPY package.json package-lock.json /build/
RUN npm ci
COPY . .
RUN npm run build && /usr/bin/hugo

FROM nginx:alpine

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /build/public /var/www
