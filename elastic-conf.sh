ELASTIC_CURL_OPT=(--user elastic:changeme)
ELASTIC_CURL_URL='http://localhost:9200'

# Example
# # INDEX=index-name
# # MAP=mappingtype-ABC
# # curl ${ELASTIC_CURL_OPT[@]} -XDELETE $ELASTIC_CURL_URL/$INDEX
# # curl ${ELASTIC_CURL_OPT[@]} -XPUT $ELASTIC_CURL_URL/$INDEX -d '{
# #   "mappings": {
# #     "'$MAP'": {
# #       "properties": {
# #         "key1": {"type": "integer"},
# #         "date": { "type": "date", "format": "yyyyMMdd HH:mm Z" }
# #       }
# #     }
# #   }
# # }'

# bulk format example
# # echo '{"index":{"_index":"index-name","_type":"'$MAP'","_id":"unique-id-123"}}
# # {"key1":"value1","id":"unique-id-123","date":"20171016 00:00 +0900"}
# # ' | curl -s ${ELASTIC_CURL_OPT[@]} -XPOST $ELASTIC_CURL_URL/_bulk --data-binary @- >/dev/null
