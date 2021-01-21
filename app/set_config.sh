#!/bin/sh
set -ex

heroku config:set "HOST=$(heroku apps:info -s | grep web_url | cut -d= -f2)"
heroku config:set "POSTGRES_ADDR=$(echo ${DATABASE_URL} | cut -d@ -f2)"
heroku config:set "POSTGRES_USER=$(echo ${DATABASE_URL} | cut -d@ -f1 | cut -d: -f2 | cut -d/ -f3)"
heroku config:set "POSTGRES_PASS=$(echo ${DATABASE_URL} | cut -d@ -f1 | cut -d: -f3)"
heroku config:set "REDIS_ADDR=$(echo ${REDIS_URL} | cut -d@ -f2)"
heroku config:set "REDIS_PASS=$(echo ${REDIS_URL} | cut -d@ -f1 | cut -d: -f3)"
