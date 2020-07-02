#!/bin/bash
# Author: Franklin E.
# Description: A very basic bash script to build Dockerfile & Upload to AWS ECR. 

PROFILE="default";
REGION="us-east-1";
REPO="368040456386.dkr.ecr.us-east-1.amazonaws.com";

function buildImage() {
    echo "Building local swimlane app image...";
    sudo docker build -t swimlane_app:latest .;
    echo "Pulling the bitnami MongoDB image...";
    sudo docker pull bitnami/mongodb:latest;
}

function uploadECR() {
    echo "Creating ECR repositories for Swimlane App & MongoDB...";
    aws ecr create-repository --repository-name swimlane_app --region=${REGION} --profile=${PROFILE};
    aws ecr create-repository --repository-name mongodb --region=${REGION} --profile=${PROFILE};
    echo "Authenticating with ECR...";
    aws ecr get-login-password --region ${REGION} | sudo docker login --username AWS --password-stdin ${REPO};
    echo "Pushing swimlane app image...";
    sudo docker tag swimlane_app:latest ${REPO}/swimlane_app:latest;
    sudo docker push ${REPO}/swimlane_app:latest;
    echo "Pushing mongodb app image...";
    sudo docker tag bitnami/mongodb:latest ${REPO}/mongodb:latest;
    sudo docker push ${REPO}/mongodb:latest;
}

buildImage
uploadECR