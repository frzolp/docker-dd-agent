#!/bin/bash

if [[ $API_KEY ]]; then
	sed -i -e "s/^.*api_key:.*$/api_key: ${API_KEY}/" /etc/dd-agent/datadog.conf
else
	echo "You must set API_KEY environment variable to run the Datadog Agent container"
	exit 1
fi

if [[ $TAGS ]]; then
	sed -i -e "s/^#tags:.*$/tags: ${TAGS}/" /etc/dd-agent/datadog.conf
fi

export PATH="/opt/datadog-agent/embedded/bin:/opt/datadog-agent/bin:$PATH"

exec supervisord -n -c /etc/dd-agent/supervisor.conf