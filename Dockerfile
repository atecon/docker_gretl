FROM ubuntu:19.04

RUN apt update && apt install -y --no-install-recommends \
	gcc autoconf automake apt-utils \
	libtool flex bison gcc-doc libc6-dev libc-dev gfortran \
	gettext libglib2.0-dev libgtk3-perl libgfs-dev \
	libpng-dev libxslt1-dev liblapack-dev libfftw3-dev \
	libreadline-dev zlib1g-dev libxml2-dev libgmp-dev \
	libcurl4-gnutls-dev libmpfr-dev git gnuplot imagemagick \
	libjson-glib-1.0-0 libjson-glib-dev automake cmake
	
RUN mkdir -p git; \
	git clone git://git.code.sf.net/p/gretl/git ./git/gretl-git; \
	\
	cd /git/gretl-git; \
	make clean; \
        ./configure; \
	make; \
	make install; \
	make clean; \
	ldconfig

CMD ["Dockerfiles are cool!"]

#RUN apt update && apt install -y gretl
#CMD ["pwd"]
	#"/usr/local/bin/gretlcli --version", "Dockerfiles are cool!"]
