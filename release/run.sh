#!/usr/bin/env bash
set -ex

APP_ID="$(echo ${HEROKU_RELEASE_STREAM_URL} | cut -d/ -f6)"
heroku labs:enable runtime-dyno-metadata -a "${APP_ID}"
