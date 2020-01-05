FROM ubuntu:19.10

RUN apt update && apt install -y --no-install-recommends \
	gcc g++ g++-9 autoconf automake cmake apt-utils build-essential \
	libtool flex bison gcc-doc libc6-dev libc-dev gfortran \
	gettext libglib2.0-dev libgtk3-perl libgfs-dev \
	libpng-dev libxslt1-dev liblapack-dev libfftw3-dev \
	libreadline-dev zlib1g-dev libbz2-dev libxml2-dev libgmp-dev \
	libcurl4-gnutls-dev libmpfr-dev git gnuplot imagemagick \
	libjson-glib-1.0-0 libjson-glib-dev \
	openmpi-bin openmpi-common nano
	
RUN mkdir -p git; \
	git clone git://git.code.sf.net/p/gretl/git ./git/gretl-git ; \
	cd /git/gretl-git; \
        ./configure --enable-openmp; \
	make -j$(nproc); \
	make install; \
	make clean; \
	ldconfig

RUN gretlcli --version

# RUN apt purge build-essential libc6-dev libc-dev \
#	libglib2.0-dev libglib2.0-dev libgtk3-perl libgfs-dev \
#	libpng-dev libxslt1-dev liblapack-dev libfftw3-dev \
#	libreadline-dev zlib1g-dev libbz2-dev libxml2-dev libgmp-dev \
#	libcurl4-gnutls-dev libmpfr-dev git \
#	libjson-glib-1.0-0 libjson-glib-dev

#CMD ["gretlcli -e -b", "./print_data.inp"]

#RUN apt update && apt install -y gretl
#CMD ["pwd"]
	#"/usr/local/bin/gretlcli --version", "Dockerfiles are cool!"]
