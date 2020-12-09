#!/bin/bash

cd "$HOME/git/gretl-git" || exit
git pull
make clean

./configure \
	--enable-build-doc \
	--enable-build-addons \
	--enable-quiet-build

make -j"$(nproc)"
sudo make pdfdocs
sudo make install
if [ "$?" -ne 0 ] ]
then
     printf "Failed to install gretl.\\n"
     exit 1
else
	sudo make install-doc
	make clean
	sudo ldconfig

	echo "################################################################"
	echo "##################  Mmhhh, you've got a freshly   ##############"
	echo "##################  compiled gretl version...	##############"
	echo "################################################################"
	exit 0
fi
