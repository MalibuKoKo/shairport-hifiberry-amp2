FROM alpine:edge

RUN apk -U add \
        git \
        build-base \
        autoconf \
        automake \
        libtool \
        alsa-lib-dev \
        libdaemon-dev \
        popt-dev \
        libressl-dev \
        soxr-dev \
        avahi-dev \
        libconfig-dev \

 && cd /root \
 && git clone https://github.com/mikebrady/shairport-sync.git \
 && cd shairport-sync \

 && autoreconf -i -f \
 && ./configure \
        --with-alsa \
        --with-pipe \
        --with-avahi \
        --with-ssl=openssl \
        --with-soxr \
        --with-metadata \
 && make \
 && make install \

 && cd / \
 && apk --purge del \
        git \
        build-base \
        autoconf \
        automake \
        libtool \
        alsa-lib-dev \
        libdaemon-dev \
        popt-dev \
        libressl-dev \
        soxr-dev \
        avahi-dev \
        libconfig-dev \
 && apk add \
        dbus \
        alsa-lib \
        libdaemon \
        popt \
        libressl \
        soxr \
        avahi \
        libconfig \
 && rm -rf \
        /etc/ssl \
        /var/cache/apk/* \
        /lib/apk/db/* \
        /root/shairport-sync

ENV AIRPLAY_NAME_0 'gauche'
ENV AIRPLAY_PARAMETER_0 'plug:gauche1'
ENV AIRPLAY_NAME_1 'droite'
ENV AIRPLAY_PARAMETER_1 'plug:droite1'
ENV AIRPLAY_NAME_2 'stereo'
ENV AIRPLAY_PARAMETER_2 'plug:stereo1'

COPY asound.conf /etc/asound.conf

COPY start.sh /start
ENTRYPOINT [ "/start" ]
