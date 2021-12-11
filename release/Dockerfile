FROM alpine

RUN apk update \
  && apk --no-cache add bash curl nodejs \
  && curl https://cli-assets.heroku.com/install.sh | bash

COPY . .
CMD ["./run.sh"]
