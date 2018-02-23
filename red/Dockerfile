FROM nanobox/fpm-cookery:ubuntu

ARG RED_VERSION
ENV RED_VERSION $RED_VERSION
ARG LIBBFRAME_VERSION
ENV LIBBFRAME_VERSION $LIBBFRAME_VERSION
ARG LIBMSGXCHNG_VERSION
ENV LIBMSGXCHNG_VERSION $LIBMSGXCHNG_VERSION

ADD https://d1qjolj82nwh57.cloudfront.net/deb/libbframe_${LIBBFRAME_VERSION}_amd64.deb /var/tmp
ADD https://d1qjolj82nwh57.cloudfront.net/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb /var/tmp

RUN apt-get install -y libmsgpack3

RUN dpkg -i /var/tmp/libbframe_${LIBBFRAME_VERSION}_amd64.deb
RUN dpkg -i /var/tmp/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb

COPY recipe.rb /var/tmp

RUN cd /var/tmp; fpm-cook

CMD cat /var/tmp/pkg/red_${RED_VERSION}_amd64.deb