include defaults.mk

ELIXIR_IMAGE:= $(PREFIX)/photon-elixir:$(ELIXIR_IMAGE_TAG)
QUAY_ELIXIR_IMAGE:=$(QUAY_PREFIX)/photon-elixir:$(ELIXIR_IMAGE_TAG)

DEV_ELIXIR_IMAGE:=$(PREFIX)/photon-elixir
DEV_QUAY_ELIXIR_IMAGE:=$(QUAY_PREFIX)/photon-elixir

all: build-elixir-image push-elixir-image
dev: build-dev-elixir-image push-dev-elixir-image

run-elixir:
	docker run -it $(DEV_ELIXIR_IMAGE):$(ELIXIR_IMAGE_TAG) bash

build-elixir-image:
	$(DOCKER) build -f $(BUILD_PATH)/Dockerfile -t $(ELIXIR_IMAGE) -t ${QUAY_ELIXIR_IMAGE} -t $(DEV_ELIXIR_IMAGE):latest $(BUILD_PATH) 

build-dev-elixir-image:
	$(DOCKER) build -f $(BUILD_PATH)/Dockerfile -t $(DEV_QUAY_ELIXIR_IMAGE):$(ELIXIR_IMAGE_TAG) -t $(DEV_QUAY_ELIXIR_IMAGE):latest $(BUILD_PATH)
	
push-elixir-image:
	$(DOCKER) push $(ELIXIR_IMAGE)
	$(DOCKER) push $(DEV_ELIXIR_IMAGE):latest

push-dev-elixir-image:
	$(DOCKER) push $(QUAY_ELIXIR_IMAGE)
	$(DOCKER) push $(DEV_QUAY_ELIXIR_IMAGE):latest
