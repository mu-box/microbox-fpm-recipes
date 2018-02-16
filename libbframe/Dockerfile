FROM nanobox/fpm-cookery:ubuntu

ARG LIBBFRAME_VERSION
ENV LIBBFRAME_VERSION $LIBBFRAME_VERSION

COPY recipe.rb /var/tmp

RUN cd /var/tmp; fpm-cook

CMD cat /var/tmp/pkg/libbframe_${LIBBFRAME_VERSION}_amd64.deb