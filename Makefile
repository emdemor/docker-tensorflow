-include .env

export

PROJECT_NAME = tf_gpu
PACKAGE_NAME = tf_gpu

PWD := $(shell pwd)

DOCKER_IMG := $(PROJECT_NAME):latest
DOCKER_ENV := --env-file .env

DOCKER_RUN := docker run --rm -t

build:
	docker build -f Dockerfile -t $(DOCKER_IMG) .

start: build
	docker run --rm $(DOCKER_ENV) -v ./.cache:/root/.cache -v ./.jupyter:/root/.jupyter -v ./project:/project -i --gpus all -p 8888:8888 -t $(DOCKER_IMG)

shell: build
	docker run --rm $(DOCKER_ENV) -v ./project:/project -i --gpus all -p 8888:8888 -t $(DOCKER_IMG) /bin/bash
