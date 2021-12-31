ARG AUTOMUTEUS_TAG=latest
ARG GALACTUS_TAG=latest
FROM denverquane/amongusdiscord:${AUTOMUTEUS_TAG} AS automuteus
FROM automuteus/galactus:${GALACTUS_TAG} AS galactus

FROM nginx:alpine

RUN apk update \
  && apk --no-cache add supervisor

WORKDIR /app

COPY --from=automuteus /app ./automuteus
COPY --from=galactus /app ./galactus
COPY default.conf.template /etc/nginx/templates/
COPY run.sh supervisord.conf ./

ENV BROKER_PORT="8123"
ENV GALACTUS_ADDR="http://localhost:5858"
ENV GALACTUS_PORT="5858"
EXPOSE 80
CMD ["./run.sh"]
