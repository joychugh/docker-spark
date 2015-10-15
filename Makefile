include env_make
NS = joychugh
VERSION ?= latest

BASE_REPO = spark-base
MASTER_REPO = spark-master
WORKER_REPO = spark-worker
MASTER_NAME = spark-master
WORKER_NAME ?= spark-worker
INSTANCE = default

.PHONY:
	build push shell run start stop rm release

build:
	docker build -t $(NS)/$(BASE_REPO):$(VERSION) .
	docker build -t $(NS)/$(MASTER_REPO):$(VERSION) master/
	docker build -t $(NS)/$(WORKER_REPO):$(VERSION) worker/

push:
	docker push $(NS)/$(BASE_REPO):$(VERSION)
	docker push $(NS)/$(MASTER_REPO):$(VERSION)
	docker push $(NS)/$(WORKER_REPO):$(VERSION)

shell:
	docker run --rm --name $(MASTER_NAME)-$(INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(MASTER_REPO):$(VERSION) /bin/bash

run-master:
	docker run --rm --name $(MASTER_NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(MASTER_REPO):$(VERSION)

run-worker:
	docker run --rm --name $(WORKER_NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(WORKER_REPO):$(VERSION)

start-master:
	docker run -d -t --name $(MASTER_NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(MASTER_REPO):$(VERSION)

start-worker:
	docker run -d -t --name $(WORKER_NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) \
	--link $(MASTER_NAME)-$(INSTANCE):MASTER $(NS)/$(WORKER_REPO):$(VERSION)

stop-master:
	docker stop $(MASTER_NAME)-$(INSTANCE)

stop-worker:
	docker stop $(WORKER_NAME)-$(INSTANCE)

rm-master:
	docker rm $(MASTER_NAME)-$(INSTANCE)

rm-worker:
	docker rm $(WORKER_NAME)-$(INSTANCE)

release:
	build make push -e VERSION=$(VERSION)

default:
	build