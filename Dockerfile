ARG IMAGE="ubuntu:20.10"
ARG VERSION="0.1"
ARG MAINTAINER="atecon@posteo.de"
ARG GRETL_VERSION="2020f"
ARG TODAY="2020-12-15"



FROM ${IMAGE}

COPY ./src/compile-gretl.sh .

LABEL maintainer=${MAINTAINER}
LABEL version=${VERSION}
LABEL description="Docker image based on ${IMAGE} with compiled Gretl version ${GRETL_VERSION} (date: ${TODAY}). Extra tools installed: git, nano"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Berlin

# Use RUN instructions to build your image by adding layers on top of initial image
RUN apt-get update -qq && apt-get install -yq \
	--no-install-recommends --no-install-recommends \
	gcc \
	g++ \
	g++-9 \
	autoconf \
	automake \
	cmake \
	build-essential \
	libtool \
	flex \
	bison \
	gcc-doc \
	libc6-dev \
	libc-dev \
	gfortran \
	gettext \
	libglib2.0-dev \
	libgtk3-perl \
	libgfs-dev \
	libpng-dev \
	libxslt1-dev \
	liblapack-dev \
	libfftw3-dev \
	libreadline-dev \
	zlib1g-dev \
	libbz2-dev \
	libxml2-dev \
	libgmp-dev \
	libcurl4-gnutls-dev \
	libmpfr-dev \
	git \
	gnuplot \
	imagemagick \
	libjson-glib-1.0-0 \
	libjson-glib-dev \
	openmpi-bin \
	openmpi-common \
	libopenmpi-dev \
	nano \
	ca-certificates \
	libgtk-3-dev \
	libgtksourceview-3.0-dev \
	libgsf-1-dev

# Use RUN instructions to build your image by adding layers on top of initial image
RUN mkdir -p git \
	&& git clone git://git.code.sf.net/p/gretl/git ./git/gretl-git \
	&& export MPILINK="-L/usr/lib/x86_64-linux-gnu/openmpi/lib -lmpi" \
	&& sh compile-gretl.sh

RUN gretlcli --version

# Get rid of unnecessary libs which are only needed for compilation
RUN apt-get purge -yq \
	build-essential \
	autoconf \
	automake \
	cmake \
	libtool \
	flex \
	bison \
	gcc-doc \
	gfortran \
	gcc \
	g++ \
	g++-9 \
	libopenmpi-dev \
	libjson-glib-dev \
	libgtk3-perl \
	libgtk-3-dev \
	libgtksourceview-3.0-dev \
	libpng-dev \
	liblapack-dev \
	libfftw3-dev \
	libreadline-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get -y autoremove

# DO NOT un-install the following packages
# gettext libc6-dev libc-dev libglib2.0-dev zlib1g-dev libbz2-dev libxml2-dev 	libgmp-dev libcurl4-gnutls-dev libmpfr-dev \
