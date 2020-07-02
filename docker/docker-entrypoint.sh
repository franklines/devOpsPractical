#!/bin/bash
# Author: Franklin E.
# Description: docker entrypoint to configure nodejs app.

cd /opt/swimlane/devops-practical/;

npm install;

echo "${MONGODB_URL}" >> /opt/swimlane/devops-practical/.env

npm start;
