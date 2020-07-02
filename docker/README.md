## Swimlane Practical Docker Image
This repo subdir contains everything Docker related to the swimlane practice app.

## Required environment variable
```bash
MONGODB_URL=mongodb://<user>:<pass>@<mongodb>:27017/<database name>
```

## Deploy/destroy local stack using Docker Compose
```bash
# Build image
sudo docker build -t swimlane_app:latest .

# Deploy
sudo docker-compose -f docker-compose.yaml up -d

# Destroy
sudo docker-compose -f docker-compose.yaml down
```

## Build & Upload Docker Image to AWS ECR
```bash
# Update scripts hard-coded vars.
vim buildUpload.sh

# Run script
./buildUpload.sh
```