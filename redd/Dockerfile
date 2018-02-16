FROM nanobox/fpm-cookery:ubuntu

ARG REDD_VERSION
ENV REDD_VERSION $REDD_VERSION

COPY recipe.rb /var/tmp

RUN cd /var/tmp; fpm-cook

CMD cat /var/tmp/pkg/redd_${REDD_VERSION}_amd64.deb