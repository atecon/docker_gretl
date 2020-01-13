ARG IMAGE="ubuntu:19.10"

FROM ${IMAGE}

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
	ca-certificates \
	libgtk-3-dev \
	libgtksourceview-3.0-dev

RUN mkdir -p git; \
	git clone git://git.code.sf.net/p/gretl/git ./git/gretl-git ; \
	cd ./git/gretl-git; \
   	./configure --enable-openmp --with-mpi-lib=/usr/lib/x86_64-linux-gnu/openmpi/lib; \
	make -j$(nproc); \
	make install; \
	make clean; \
	ldconfig

RUN apt -y autoremove && rm -rf /var/lib/apt/lists/*
