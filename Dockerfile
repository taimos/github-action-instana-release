# Container image that runs your code
FROM alpine:3.10

RUN apk add --no-cache curl jq

RUN curl --silent https://api.github.com/repos/taimos/github-action-instana-release/releases/latest | jq -r '.tag_name' > /.version

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]