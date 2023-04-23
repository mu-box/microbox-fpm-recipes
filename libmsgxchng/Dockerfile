FROM mubox/fpm-cookery:ubuntu

ARG LIBMSGXCHNG_VERSION
ENV LIBMSGXCHNG_VERSION $LIBMSGXCHNG_VERSION

COPY recipe.rb /var/tmp

RUN cd /var/tmp; fpm-cook

CMD cat /var/tmp/pkg/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb
