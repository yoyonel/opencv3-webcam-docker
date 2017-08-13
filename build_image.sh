#!/usr/bin/env/ bash

DOCKER_IMAGE=${USER}/opencv-3.1.0:ubuntu

docker build \
	-t ${DOCKER_IMAGE} \
	.
