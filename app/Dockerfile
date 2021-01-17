ARG AUTOMUTEUS_TAG=latest
ARG GALACTUS_TAG=latest
FROM denverquane/amongusdiscord:${AUTOMUTEUS_TAG} AS automuteus
FROM automuteus/galactus:${GALACTUS_TAG} AS galactus

FROM openresty/openresty:alpine
COPY --from=automuteus /app /automuteus
COPY --from=galactus /app /galactus

RUN apk update \
  && apk --no-cache add bash curl nodejs ruby supervisor \
  && curl https://cli-assets.heroku.com/install.sh | bash

COPY nginx.conf.erb /usr/local/openresty/nginx/conf/
COPY supervisord.conf /etc/supervisord.conf
COPY set_config.sh .

ENV BROKER_PORT="8123"
ENV GALACTUS_ADDR="http://localhost:5858"
ENV GALACTUS_PORT="5858"

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
