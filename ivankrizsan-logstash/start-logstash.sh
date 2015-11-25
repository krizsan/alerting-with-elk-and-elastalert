#!/bin/bash

set -e

# Add logstash as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- logstash "$@"
fi

# Wait until Elasticsearch is online.
while ! curl -s ${ELASTICSEARCH_URL}
do
    echo "Waiting for Elasticsearch..."
    sleep 2
done
sleep 5

# Run as user "logstash" if the command is "logstash"
if [ "$1" = 'logstash' ]; then
	set -- gosu logstash "$@"
fi

exec "$@"
