FROM mubox/fpm-cookery:ubuntu

ARG NARC_VERSION
ENV NARC_VERSION $NARC_VERSION

COPY recipe.rb /var/tmp

RUN cd /var/tmp; fpm-cook

CMD cat /var/tmp/pkg/narc_${NARC_VERSION}_amd64.deb
