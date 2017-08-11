#!/usr/bin/env/ bash

DOCKER_IMAGE=${USER}/screenpulse/opencv3:8.0-cudnn7-devel

docker build \
	-t ${DOCKER_IMAGE} \
	.
