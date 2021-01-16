ARG GALACTUS_TAG=latest
ARG AUTOMUTEUS_TAG=latest
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
COPY run.sh .

EXPOSE 80
CMD ["bash", "run.sh"]
