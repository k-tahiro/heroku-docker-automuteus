#!/usr/bin/env bash
set -ex

env

APP_ID="$(echo ${HEROKU_RELEASE_STREAM_URL} | cut -d/ -f6)"

heroku config:set "HOST=$(heroku apps:info -s -a ${APP_ID} | grep web_url | cut -d= -f2)" -a "${APP_ID}"
heroku config:set "POSTGRES_ADDR=$(echo ${DATABASE_URL} | cut -d@ -f2)" -a "${APP_ID}"
heroku config:set "POSTGRES_USER=$(echo ${DATABASE_URL} | cut -d@ -f1 | cut -d: -f2 | cut -d/ -f3)" -a "${APP_ID}"
heroku config:set "POSTGRES_PASS=$(echo ${DATABASE_URL} | cut -d@ -f1 | cut -d: -f3)" -a "${APP_ID}"
heroku config:set "REDIS_ADDR=$(echo ${REDIS_URL} | cut -d@ -f2)" -a "${APP_ID}"
heroku config:set "REDIS_PASS=$(echo ${REDIS_URL} | cut -d@ -f1 | cut -d: -f3)" -a "${APP_ID}"
