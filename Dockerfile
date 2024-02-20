# Container image that runs your code
FROM alpine:3.19.1

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY reviewer-auto-assignment.sh /reviewer-auto-assignment.sh
COPY reviewer-auto-assignment.py /reviewer-auto-assignment.py
COPY requirements.in /requirements.in

RUN apk add --no-cache curl jq bash

RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
