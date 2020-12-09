ARG IMAGE="ubuntu:20.10"

FROM ${IMAGE}

LABEL maintainer="atecon@posteo.de"
LABEL version="0.1"
LABEL description="Docker image based on ${IMAGE} for compitiling latest version of Gretl available (gretl.sourceforge.net/)."

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Berlin

RUN apt-get update -qq && apt-get install -yq \
	--no-install-recommends --no-install-recommends \
	gcc \
	g++ \
	g++-9 \
	autoconf \
	automake \
	cmake \
	# apt-utils \
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

RUN mkdir -p git && git clone git://git.code.sf.net/p/gretl/git ./git/gretl-git

RUN ls ./git/gretl-git && cd ./git/gretl-git && git config pull.rebase false && git pull

RUN ./configure --enable-build-doc --enable-build-addons --enable-quiet-build \
	&& make -j$(nproc) \
	&& make install \
	&& make clean \
	&& ldconfig

RUN apt -y autoremove && rm -rf /var/lib/apt/lists/*
