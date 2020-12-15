#!/bin/bash

cd "git/gretl-git" || exit

export MPILINK="-L/usr/lib/x86_64-linux-gnu/openmpi/lib -lmpi"

./configure \
	--enable-build-addons \
	--enable-quiet-build \
	--enable-gui=no \
	--enable-build-doc=no \
	--with-mpi-lib=/usr/lib/x86_64-linux-gnu/openmpi #\
	#--enable-openmp


make -j"$(nproc)"
make install
if [ "$?" -ne 0 ] ]
then
     echo "Failed to install gretl."
     exit 1
else
	make clean
	ldconfig

	echo "################################################################"
	echo "##################  Mmhhh, you've got a freshly   ##############"
	echo "##################  compiled gretl version...	##############"
	echo "################################################################"
	exit 0
fi
