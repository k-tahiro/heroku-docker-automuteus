# import dependencies
ARG AUTOMUTEUS_TAG=theGreatSchism
ARG GALACTUS_TAG=theGreatSchism
ARG WINGMAN_TAG=main
FROM denverquane/amongusdiscord:${AUTOMUTEUS_TAG} AS automuteus
FROM automuteus/galactus:${GALACTUS_TAG} AS galactus
FROM automuteus/wingman:${WINGMAN_TAG} AS wingman
FROM openresty/openresty:alpine

# setup automuteus
COPY --from=automuteus /app /automuteus
RUN true
COPY --from=automuteus /app/locales/ /automuteus/locales
RUN true
COPY --from=automuteus /app/storage/postgres.sql /automuteus/storage/postgres.sql
RUN true
ENV LOCAL_PATH=/automuteus/locales LOG_PATH=/automuteus/logs
VOLUME [/automuteus/logs]

# setup galactus
COPY --from=galactus /app /galactus
RUN true

# setup wingman
COPY --from=wingman /app /wingman
RUN true

# setup openresty
COPY nginx.conf.erb /usr/local/openresty/nginx/conf/
RUN true

# setup supervisord
RUN apk update \
  && apk --no-cache add ruby supervisor
COPY supervisord.conf /etc/supervisord.conf
RUN true
COPY run.sh .
RUN true

# setup envrionment variables
ENV WINGMAN_PORT="8123"
ENV GALACTUS_PORT="5858"
ENV GALACTUS_ADDR="http://localhost:5858"

# entrypoint
EXPOSE 80
CMD ["sh", "run.sh"]
