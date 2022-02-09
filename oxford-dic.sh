#!/usr/bin/env bash

set -euo pipefail

if ! command -v curl jq &> /dev/null; then
  echo "install: curl, jq" >&2
  exit 1
fi

if [ -f ~/.config/describe ]; then
  . ~/.config/describe
else
  # app_id='...'
  # app_key='...'
  exit 1
fi
if [ -z "$app_id" ]; then
  echo "not be set: app_id" >&2
  exit 1
elif [ -z "$app_key" ]; then
  echo "not be set: app_key" >&2
  exit 1
fi


# `word_id`:
word_id="$(echo "${1-test}" | tr 'A-Z' 'a-z')"
echo "Target word: ${word_id}" >&2

# `endpoint_base`:
#    Ref: https://od-api.oxforddictionaries.com:443/api/v2
endpoint_base='https://od-api.oxforddictionaries.com:443/api/v2'

# `endpoint_type`:
#   Ref: https://developer.oxforddictionaries.com/documentation
#   General: entries|lemmas|search|translations|thesaurus|sentences|words|inflections
#     - /entries/{source_lang}/{word_id}
#     - /lemmas/{source_lang}/{word_id}
#     - /search/translations/{source_lang_search}/{target_lang_search}
#     - /search/{source_lang}
#     - /search/thesaurus/{source_lang}
#     - /translations/{source_lang_translate}/{target_lang_translate}/{word_id}
#     - /thesaurus/{lang}/{word_id}
#     - /sentences/{source_lang}/{word_id}
#     - /words/{source_lang}
#     - /inflections/{source_lang}/{word_id}
#   Utility: domains|fields|filters|grammaticalFeatures|languages|lexicalCategories|reigsters
#     - /domains/{source_lang}
#     - /domains/{source_lang_domains}/{target_lang_domains}
#     - /fields
#     - /fields/{endpoint}
#     - /filters
#     - /filters/{endpoint}
#     - /grammaticalFeatures/{source_lang}
#     - /grammaticalFeatures/{source_lang_grammatical}/{target_lang_grammatical}
#     - /languages
#     - /lexicalCategories/{source_lang}
#     - /lexicalCategories/{source_lang_lexical}/{target_lang_lexical}
#     - /registers/{source_lang}
# endpoint_type='${2-entries}'
endpoint_type='entries'
echo "Target endpoint: ${endpoint_type}" >&2

# `source_lang`:
#   Ref: https://developer.oxforddictionaries.com/documentation/languages
#   Language codes:
#     en-us|en|ar|zh|fa|fr|ka|de|el|gu|ha|hi|ig|id|
#     xh|zu|it|lv|ms|mr|nso|pt|qu|ro|ru|tn|es|sw|tg|
#     ta|tt|te|tpi|tk|ur|yo
source_lang='en-gb'

function _req(){
  curl -s \
    -X GET \
    -H 'Accept: application/json' \
    -H "app_id: ${app_id}" -H "app_key: ${app_key}" \
    "$1"
}

_req "${endpoint_base}/${endpoint_type}/${source_lang}/${word_id}" |
jq -r '"Definitions:\n- "+ ([.results[].lexicalEntries[].entries[].senses[].shortDefinitions|select(.!=null)|add]|join("\n- "))'
