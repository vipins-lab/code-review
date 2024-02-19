# Container image that runs your code
FROM dwdraju/alpine-curl-jq

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY reviewer-auto-assignment.sh /reviewer-auto-assignment.sh
COPY requirements.in /requirements.in

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
