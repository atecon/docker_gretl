ARG IMAGE="ubuntu:19.10"
#ARG GRETL_GIT_URL="git://git.code.sf.net/p/gretl/git"

#LABEL maintainer="atecon@posteo.de"

FROM $IMAGE 

RUN apt update -qq && apt install -y --no-install-recommends \
	gcc \
	g++ \
	g++-9 \
	autoconf \
	automake \
	cmake \
	apt-utils \
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
	nano \
	ca-certificates

RUN mkdir -p git; \
	git clone git://git.code.sf.net/p/gretl/git ./git/gretl-git ; \
	cd ./git/gretl-git; \
    	./configure --enable-openmp; \
	make -j$(nproc); \
	make install; \
	make clean; \
	ldconfig


RUN apt -y autoremove && rm -rf /var/lib/apt/lists/*
