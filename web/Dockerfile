ARG AUTOMUTEUS_TAG=latest
ARG GALACTUS_TAG=latest
FROM denverquane/amongusdiscord:${AUTOMUTEUS_TAG} AS automuteus
FROM automuteus/galactus:${GALACTUS_TAG} AS galactus

FROM openresty/openresty:alpine

RUN apk update \
  && apk --no-cache add ruby supervisor

WORKDIR /app

COPY --from=automuteus /app ./automuteus
COPY --from=galactus /app ./galactus
COPY . .

ENV BROKER_PORT="8123"
ENV GALACTUS_ADDR="http://localhost:5858"
ENV GALACTUS_PORT="5858"
EXPOSE 80
CMD ["./run.sh"]
