#!/bin/sh
set -ex

env

export HOST="https://${APP_ID}.herokuapp.com"
/usr/bin/supervisord -c /etc/supervisord.conf
