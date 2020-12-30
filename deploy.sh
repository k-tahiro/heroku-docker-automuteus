#!/bin/bash
set -ex

readonly HEROKU_DIR="$(cd $(dirname $0) && pwd)"
readonly ENV_FILE=".env"


function create_app() {
  local app_name="$1"

  heroku plugins:install heroku-config

  heroku create "${app_name}"
  heroku addons:create heroku-postgresql:hobby-dev -a "${app_name}" --wait
  heroku addons:create heroku-redis:hobby-dev -a "${app_name}" --wait

  if [[ ! -e "${ENV_FILE}" ]]; then
    cp sample.env "${ENV_FILE}"
  fi

  echo "HOST=\"https://${app_name}.herokuapp.com\"" >>"${ENV_FILE}"
}

function update_app() {
  local app_name="$1"
  
  heroku config:pull -a "${app_name}"
  source "${ENV_FILE}"
  if !(grep POSTGRES_ADDR "${ENV_FILE}"); then
    echo "POSTGRES_ADDR=$(echo ${DATABASE_URL} | cut -d@ -f2)" >>"${ENV_FILE}"
  fi
  if !(grep POSTGRES_USER "${ENV_FILE}"); then
    echo "POSTGRES_USER=$(echo ${DATABASE_URL} | cut -d@ -f1 | cut -d: -f2 | cut -d/ -f3)" >>"${ENV_FILE}"
  fi
  if !(grep POSTGRES_PASS "${ENV_FILE}"); then
    echo "POSTGRES_PASS=$(echo ${DATABASE_URL} | cut -d@ -f1 | cut -d: -f3)" >>"${ENV_FILE}"
  fi
  if !(grep REDIS_ADDR "${ENV_FILE}"); then
    echo "REDIS_ADDR=$(echo ${REDIS_URL} | cut -d@ -f2)" >>"${ENV_FILE}"
  fi
  if !(grep REDIS_PASS "${ENV_FILE}"); then
    echo "REDIS_PASS=$(echo ${REDIS_URL} | cut -d@ -f1 | cut -d: -f3)" >>"${ENV_FILE}"
  fi
  heroku config:push -a "${app_name}"

  heroku container:push --recursive -a "${app_name}"
  heroku container:release web -a "${app_name}"
}


function main() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: $0 APP_NAME" 1>&2
    exit 1
  fi

  pushd "${HEROKU_DIR}"

  local app_name="$1"
  if !(heroku list | grep -E "^${app_name}$"); then
    create_app "${app_name}"
  fi

  update_app "${app_name}"

  popd
}

main "$@"
