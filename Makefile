include defaults.mk

ELIXIR_IMAGE:= $(PREFIX)/photon-elixir:$(ELIXIR_IMAGE_TAG)

DEV_ELIXIR_IMAGE:=$(PREFIX)/photon-elixir

all: build-elixir-image push-elixir-image

run-elixir:
	docker run -it $(DEV_ELIXIR_IMAGE):$(ELIXIR_IMAGE_TAG) bash

build-elixir-image:
	$(DOCKER) build --build-arg BUILD_DATE=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ') -f $(BUILD_PATH)/Dockerfile -t $(ELIXIR_IMAGE) -t $(DEV_ELIXIR_IMAGE):latest $(BUILD_PATH) 
	
push-elixir-image:
	$(DOCKER) push $(ELIXIR_IMAGE)
	$(DOCKER) push $(DEV_ELIXIR_IMAGE):latest
