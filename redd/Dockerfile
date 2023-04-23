FROM mubox/fpm-cookery:ubuntu

ARG REDD_VERSION
ENV REDD_VERSION $REDD_VERSION
ARG LIBBFRAME_VERSION
ENV LIBBFRAME_VERSION $LIBBFRAME_VERSION
ARG LIBMSGXCHNG_VERSION
ENV LIBMSGXCHNG_VERSION $LIBMSGXCHNG_VERSION

ADD https://s3.amazonaws.com/tools.microbox.cloud/deb/libbframe_${LIBBFRAME_VERSION}_amd64.deb /var/tmp
ADD https://s3.amazonaws.com/tools.microbox.cloud/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb /var/tmp

RUN apt-get install -y libmsgpack3

RUN dpkg -i /var/tmp/libbframe_${LIBBFRAME_VERSION}_amd64.deb
RUN dpkg -i /var/tmp/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb

COPY recipe.rb /var/tmp

RUN cd /var/tmp; fpm-cook

CMD cat /var/tmp/pkg/redd_${REDD_VERSION}_amd64.deb
