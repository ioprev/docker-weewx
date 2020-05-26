FROM jgoerzen/debian-base-security:buster
MAINTAINER John Goerzen <jgoerzen@complete.org>
COPY setup/ /tmp/setup/
ENV WEEWX_VERSION 4.1.0
# The font file is used for the generated images
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -y --no-install-recommends install ssh rsync fonts-freefont-ttf && \
    apt-get -y --no-install-recommends install libfreetype6 libimagequant0 libjbig0 \
      libjpeg62-turbo liblcms2-2 libpng16-16 libtiff5 libusb-1.0-0 libwebp6 libwebpdemux2 \
      libwebpmux3 python3-cheetah python3-configobj python3-pil python3-serial python3-six python3-usb && \
    /tmp/setup/setup.sh && \
    apt-get -y -u dist-upgrade && \
    apt-get clean && rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled && \
    mkdir -p /var/www/html/weewx

VOLUME ["/var/lib/weewx"]
CMD ["/usr/local/bin/boot-debian-base"]
