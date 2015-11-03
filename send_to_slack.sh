#!/bin/bash

# Set Env
CHANNEL="#nagios"
WEBHOOK_URL="https://hooks.slack.com/services/<Incomming WebhookのURL>"
MESSAGE="$3"

# Option Check
while getopts "s:" opts
do
  case $opts in
    s) status=$OPTARG ;;
  esac
done

# Set the message icon 
if [ "$status" = "CRITICAL" ]
then
    ICON=":exclamation:"
    COLOR="danger"
elif [ "$status" = "WARNING" ]
then
    ICON=":warning:"
    COLOR="warning"
elif [ "$status" = "OK" ]
then
    ICON=":white_check_mark:"
    COLOR="good"
elif [ "$status" = "UNKNOWN" ]
then
    ICON=":question:"
    COLOR="#ff0000 "
else
    ICON=":white_medium_square:"
    COLOR="danger"
fi

# Send to slack
curl -m 5 --data  "payload={\"icon_url\": \"https://slack.com/img/services/nagios_48.png\", \"channel\": \"${CHANNEL}\", \"text\": \" ${ICON} ${COLOR} ${MESSAGE}\"}" ${WEBHOOK_URL}

