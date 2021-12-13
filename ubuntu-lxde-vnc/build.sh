#!/bin/bash
docker build -t ubuntu-windowed:latest .
CGO_ENABLED=0 poco bundle --image ubuntu-windowed:latest --local --entrypoint /startup.sh --app-mounts /sys --app-mounts /run --app-mounts /tmp --app-mounts /etc/resolv.conf