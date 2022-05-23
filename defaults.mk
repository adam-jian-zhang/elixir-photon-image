DOCKER ?= docker
BUILD_PATH ?= .
PRODUCT_VERSION ?= 1.0.0
PREFIX ?= projects.registry.vmware.com/tkgi
QUAY_PREFIX ?=quay.io/ranz
BUILD_NUMBER ?= $(shell date +%Y%m%d)
IMAGE_TAG ?= $(PRODUCT_VERSION).$(BUILD_NUMBER)
DEV_IMAGE_TAG ?= $(PRODUCT_VERSION)
ELIXIR_IMAGE_TAG ?= v1.13.4