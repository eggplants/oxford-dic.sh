#!/usr/bin/env bash

set -euo pipefail

if [ -f ~/.config/describe ]; then
  . ~/.config/describe
else
  # app_id='...'
  # app_key='...'
  exit 1
fi

word="${1-test}"
echo "word: ${word}"

base_url='https://od-api.oxforddictionaries.com:443/api/v2/entries'
language='en-gb'

curl -s \
  -X GET \
  -H "app_id: ${app_id}" -H "app_key: ${app_key}" \
  "${base_url}/${language}/${word}"
