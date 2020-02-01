#!/bin/sh -le

echo "Creating release $1"

res=$(curl --location --request POST "${INSTANA_BASE}/api/releases" \
  --header "Authorization: apiToken ${INSTANA_TOKEN}" \
  --header "Content-Type: application/json" \
  --data "{
	\"name\": \"${1}\",
	\"start\": $(date +%s)000
}")

echo $res

id=$(echo "$res" | jq ".id" -r)

echo ::set-output name=id::$id
