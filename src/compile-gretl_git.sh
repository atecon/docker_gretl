#!/bin/bash
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# Website 	: 	http://www.erikdubois.be
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

# Downloading and installing latest teamviewer
cd $HOME/git/gretl-git
git pull
make clean
./configure --enable-build-doc --enable-openmp --with-mpi-lib=/usr/lib/x86_64-linux-gnu/openmpi/lib --with-libsvm
make -j$(nproc)
make pdfdocs
sudo make install
sudo make install-doc
sudo make clean
sudo ldconfig

echo "################################################################"
echo "##################  Mmhhh, you've got a freshly   ##############"
echo "##################  compiled gretl version...	##############"
echo "################################################################"
