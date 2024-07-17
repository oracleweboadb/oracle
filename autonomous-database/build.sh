#! /bin/bash
cd "$(dirname "$0")"

podman build -f Dockerfile -t CUSTOM_IMAGE_$TAG .
