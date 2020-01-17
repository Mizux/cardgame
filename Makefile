PROJECT := cardgame
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
SHA1 := $(shell git rev-parse --verify HEAD)

# General commands
.PHONY: help
BOLD=\e[1m
RESET=\e[0m

help:
	@echo -e "${BOLD}SYNOPSIS${RESET}"
	@echo -e "\tmake <target> [NOCACHE=1]"
	@echo
	@echo -e "${BOLD}DESCRIPTION${RESET}"
	@echo -e "\ttest build inside docker container to have a reproductible build."
	@echo
	@echo -e "${BOLD}MAKE TARGETS${RESET}"
	@echo -e "\t${BOLD}help${RESET}: display this help and exit."
	@echo
	@echo -e "\t${BOLD}env${RESET}: build a virtual env image."
	@echo -e "\t${BOLD}run_env${RESET}: run a container using the virtual env image (debug purpose)."
	@echo
	@echo -e "\t${BOLD}devel${RESET}: build the app in a devel image."
	@echo -e "\t${BOLD}run_devel${RESET}: run a container using the devel image (debug purpose)."
	@echo -e "\t${BOLD}test_devel${RESET}: auto test using the devel image."
	@echo
	@echo -e "\t${BOLD}clean${RESET}: Remove log files and docker image."
	@echo
	@echo -e "\t${BOLD}NOCACHE=1${RESET}: use 'docker build --no-cache' when building container (default use cache)."
	@echo
	@echo -e "branch: $(BRANCH)"
	@echo -e "sha1: $(SHA1)"

# Need to add cmd_distro to PHONY otherwise target are ignored since they do not
# contain recipe (using FORCE do not work here)
.PHONY: all
all: serve

# Delete all implicit rules to speed up makefile
MAKEFLAGS += --no-builtin-rules
.SUFFIXES:
# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =
# Keep all intermediate files
# ToDo: try to remove it later
.SECONDARY:

# Docker image name prefix.
IMAGE := ${PROJECT}

ifdef NOCACHE
DOCKER_BUILD_CMD := docker build --no-cache
else
DOCKER_BUILD_CMD := docker build
endif

DOCKER_RUN_CMD := docker run --rm --init --name ${IMAGE}

# $* stem
# $< first prerequist
# $@ target name


#######
# ENV #
#######
# Build the env image.
.PHONY: env
env: cache/docker_env.tar
cache/docker_env.tar: docker/Dockerfile
	mkdir -p cache
	@docker image rm -f ${IMAGE}:env 2>/dev/null
	${DOCKER_BUILD_CMD} --target=env -t ${IMAGE}:env -f $< .
	@rm -f $@
	docker save ${IMAGE}:env -o $@

# Run a container using the env image.
.PHONY: run_env
run_env: cache/docker_env.tar
	${DOCKER_RUN_CMD} -it ${IMAGE}:env /bin/sh


#########
# DEVEL #
#########
# Build the devel image.
.PHONY: devel
devel: cache/docker_devel.tar
cache/docker_devel.tar: \
 docker/Dockerfile \
 cache/docker_env.tar \
 CMakeLists.txt \
 libCard \
 card \
 .dockerignore
	mkdir -p cache
	@docker image rm -f ${IMAGE}:devel 2>/dev/null
	${DOCKER_BUILD_CMD} --target=devel -t ${IMAGE}:devel -f $< .
	@rm -f $@
	docker save ${IMAGE}:devel -o $@

# Run a container using the devel image.
.PHONY: run_devel
run_devel: cache/docker_devel.tar
	${DOCKER_RUN_CMD} -it ${IMAGE}:devel /bin/sh

# Run a container using the devel image.
.PHONY: test_devel
test_devel: cache/docker_devel.tar
	${DOCKER_RUN_CMD} -it ${IMAGE}:devel cmake --build build --target test

#########
# CLEAN #
#########
.PHONY: clean
clean:
	docker container prune -f
	docker image prune -f
	-docker image rm -f ${IMAGE}:env 2>/dev/null
	-docker image rm -f ${IMAGE}:devel 2>/dev/null
	-rm -f cache/docker_env.tar
	-rm -f cache/docker_devel.tar
	-rmdir cache

.PHONY: distclean
distclean: clean
	-docker container rm -f $$(docker container ls -aq)
	-docker image rm -f $$(docker image ls -aq)
