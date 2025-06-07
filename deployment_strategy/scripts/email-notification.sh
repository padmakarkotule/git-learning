#!/bin/bash

SERVICE_NAME="$1"
BUILD_NUMBER="$2"
BUILD_STATUS="$3"

echo "📧 Sending email notification for ${SERVICE_NAME} Build #${BUILD_NUMBER} - ${BUILD_STATUS}"

# Simulated email logic (replace with real mail CLI or plugin)
echo "Subject: ${SERVICE_NAME} Build #${BUILD_NUMBER} - ${BUILD_STATUS}" > email.log
echo "See Jenkins console log for more details." >> email.log

# For actual sending, integrate `sendmail`, `mailx`, or an API.
