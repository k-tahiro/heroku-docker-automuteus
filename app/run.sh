#!/bin/sh
set -ex

export POSTGRES_ADDR="$(echo ${DATABASE_URL} | cut -d@ -f2)"
export POSTGRES_USER="$(echo ${DATABASE_URL} | cut -d@ -f1 | cut -d: -f2 | cut -d/ -f3)"
export POSTGRES_PASS="$(echo ${DATABASE_URL} | cut -d@ -f1 | cut -d: -f3)"
export REDIS_ADDR="$(echo ${REDIS_URL} | cut -d@ -f2)"
export REDIS_PASS="$(echo ${REDIS_URL} | cut -d@ -f1 | cut -d: -f3)"

export HOST="https://${HEROKU_APP_NAME}.herokuapp.com"

/usr/bin/supervisord -c /etc/supervisord.conf
