FROM alpine

RUN apk update \
  && apk --no-cache add bash curl nodejs \
  && curl https://cli-assets.heroku.com/install.sh | bash

COPY run.sh .
CMD ["./run.sh"]
