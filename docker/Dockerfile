# Create a virtual environment with all tools installed
# ref: https://hub.docker.com/_/alpine
FROM alpine:edge AS env
LABEL maintainer="mizux.dev@gmail.com"
# Install system build dependencies
ENV PATH=$PATH:/usr/local/bin
RUN apk add --no-cache \
 git g++ clang make cmake \
 doxygen graphviz \
 qt5-qtbase-dev ttf-freefont

CMD [ "/bin/sh" ]


# Add the app src to our build env
FROM env AS devel
# Create app directory
WORKDIR /home/app
# Bundle app source
COPY . .
# CMake configure
RUN cmake -S. -Bbuild
# CMake build
RUN cmake --build build -v

CMD [ "/bin/sh" ]


# Create a production image
FROM alpine:edge AS prod
LABEL maintainer="mizux.dev@gmail.com"
# Install system runtime dependencies
ENV PATH=$PATH:/usr/local/bin
RUN apk add --no-cache qt5-qtbase ttf-freefont

# Create app directory
WORKDIR /home/app
# Copy app from devel to prod
COPY --from=devel /home/app/install /home/app

CMD [ "bin/sh" ]
