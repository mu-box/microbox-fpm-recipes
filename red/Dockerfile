FROM nanobox/fpm-cookery:ubuntu

ARG RED_VERSION
ENV RED_VERSION $RED_VERSION

COPY recipe.rb /var/tmp

RUN cd /var/tmp; fpm-cook

CMD cat /var/tmp/pkg/red_${RED_VERSION}_amd64.deb