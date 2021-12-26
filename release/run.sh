#!/usr/bin/env bash
set -ex

APP_ID="$(echo ${HEROKU_RELEASE_STREAM_URL} | cut -d/ -f6)"
export HOST=$(heroku apps:info -s -a "${APP_ID}" | grep web_url | cut -d= -f2)
