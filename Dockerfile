FROM node:23.4

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    ca-certificates \
    curl \
    unzip \
    && update-ca-certificates

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    locales \
    && sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
    && locale-gen ja_JP.UTF-8
ENV TZ=Asia/Tokyo
ENV LANG=ja_JP

RUN mkdir /tmp/noto
WORKDIR /tmp/noto
ADD https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip ./
RUN unzip NotoSansCJKjp-hinted.zip \
    && mkdir -p /usr/share/fonts/noto \
    && cp *.otf /usr/share/fonts/noto \
    && chmod 644 -R /usr/share/fonts/noto/ \
    && /usr/bin/fc-cache -fv
WORKDIR /

RUN curl -q https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y google-chrome-stable

RUN apt autoremove -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
