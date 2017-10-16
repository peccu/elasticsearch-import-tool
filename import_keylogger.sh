#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")"; pwd)
. $SCRIPT_DIR/elastic-conf.sh

LOGFILE=/var/log/keystroke.log

INDEX=type_count
# curl ${ELASTIC_CURL_OPT[@]} -XPUT $ELASTIC_CURL_URL/$INDEX -d '{
#   "mappings": {
#     "typecount": {
#       "properties": {
#         "date": { "type": "date", "format": "yyyy-MM-dd HH:mm Z" },
#         "count" : { "type": "integer" }
#       }
#     }
#   }
# }'

cat $LOGFILE| \
    grep $(date '+%Y-%m-%d')| \
    awk '{printf("%s %s %s %s %s\n", $1, substr($3, 0, 5), $5, substr($3, 0, 2), $2)}'| \
    sort|uniq -c| \
    awk '{printf("{ \"index\" : { \"_index\" : \"'$INDEX'\", \"_type\" : \"typecount\", \"_id\" : \"%s %s %s\" } }\n{\"id\": \"%s %s %s\", \"date\": \"%s %s +0900\", \"hour\": \"%s\", \"weekday\": \"%s\", \"count\": \"%s\", \"app\": \"%s\"}\n", $2, $3, $4, $2, $3, $4, $2, $3, $5, $6, $1, $4) }'| \
    head | \
    curl -s ${ELASTIC_CURL_OPT[@]} -XPOST $ELASTIC_CURL_URL/_bulk --data-binary @- \
         >/dev/null
