# Dockerfile for CMake/C++/Qt Development Environment
Currently it build environment for one distribution:
* [Alpine Linux](https://alpinelinux.org/).

## Alpine Image

From [alpine:latest](https://hub.docker.com/r/alpine/)
* [cmake](https://pkgs.alpinelinux.org/package/edge/main/x86_64/cmake)
* [make](https://pkgs.alpinelinux.org/package/edge/main/x86_64/make)
* [gcc](https://pkgs.alpinelinux.org/package/edge/main/x86_64/gcc)
* [clang](https://pkgs.alpinelinux.org/package/edge/main/x86_64/clang)
* [doxygen](https://pkgs.alpinelinux.org/package/edge/main/x86_64/doxygen)
* [graphviz](https://pkgs.alpinelinux.org/package/edge/main/x86_64/graphviz)

## Manual Build Environment
You can build an env image using:
```sh
make build_env
```

## Manual Build
You can build a devel env image using:
```sh
make build_devel
```

## Run
Then you can test the image using:
```sh
docker run --init --rm -it cardgame_<distro> bash
```
