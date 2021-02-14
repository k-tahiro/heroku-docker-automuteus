# import dependencies
ARG AUTOMUTEUS_TAG=theGreatSchism
ARG GALACTUS_TAG=theGreatSchism
ARG WINGMAN_TAG=main
FROM denverquane/amongusdiscord:${AUTOMUTEUS_TAG} AS automuteus
FROM automuteus/galactus:${GALACTUS_TAG} AS galactus
FROM automuteus/wingman:${WINGMAN_TAG} AS wingman
FROM automuteus/wingman:${WINGMAN_TAG}

# setup automuteus
COPY --from=automuteus /app /automuteus
COPY --from=automuteus /app/locales/ /automuteus/locales/
COPY --from=automuteus /app/storage/postgres.sql /automuteus/storage/postgres.sql
VOLUME [/automuteus/logs]

# setup galactus
COPY --from=galactus /app /galactus

# setup wingman
COPY --from=wingman /app /wingman

# setup openresty
FROM openresty/openresty:alpine
COPY nginx.conf.erb /usr/local/openresty/nginx/conf/

# setup supervisord
RUN apk update \
  && apk --no-cache add ruby supervisor
COPY supervisord.conf /etc/supervisord.conf
COPY run.sh .

# setup envrionment variables
ENV WINGMAN_PORT="8123"
ENV GALACTUS_PORT="5858"
ENV GALACTUS_ADDR="http://localhost:5858"

# entrypoint
EXPOSE 80
CMD ["sh", "run.sh"]
