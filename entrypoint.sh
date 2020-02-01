#!/bin/sh -l

echo "Creating release $1"

res=$(curl --location --request POST "${INSTANA_BASE}/api/releases" \
  --header "Authorization: apiToken ${INSTANA_TOKEN}" \
  --header "Content-Type: application/json" \
  --data "{
	\"name\": \"${1}\",
	\"start\": $(date +%s)000
}")

echo $res

echo ::set-output name=id::$res
