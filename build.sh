#!/bin/bash

set -e

date
ps axjf

echo $1

#################################################################
# From_Source                                                 #
#################################################################
if [ $1 = 'From_Source' ]; then
#################################################################
# Build Vcash from source                                     #
#################################################################
NPROC=$(nproc)
echo "nproc: $NPROC"
VCASH_ROOT=$(pwd)

file=test/bin/gcc-*/release/link-static/stack
if [ ! -e "$file" ]
then
    rm -rf .git
    git init .
    git remote add -t \* -f origin https://github.com/vcashcommunity/vanillacash.git
    git checkout ${VCASH_VERSION:-master}
fi

mkdir -p deps/openssl/
cd deps/openssl/
wget --no-check-certificate "https://openssl.org/source/openssl-1.0.2k.tar.gz"
tar -xzf openssl-*.tar.gz
rm -rf openssl-*.tar.gz
cd openssl-*
./config --prefix=$VCASH_ROOT/deps/openssl/
make depend && make && make install
cd $VCASH_ROOT

mkdir -p deps/db/
cd deps/db/
wget --no-check-certificate "https://download.oracle.com/berkeley-db/db-6.1.29.NC.tar.gz"
tar -xzf db-*.tar.gz
rm -rf db-*.tar.gz
cd db-*/build_unix/
../dist/configure --enable-cxx --prefix=$VCASH_ROOT/deps/db/
make && make install
cd $VCASH_ROOT

cd deps
wget "https://sourceforge.net/projects/boost/files/boost/1.53.0/boost_1_53_0.tar.gz"
tar -xzf boost*.tar.gz
rm -rf boost*.tar.gz
mv boost* boost
cd boost
./bootstrap.sh
./bjam link=static toolset=gcc cxxflags=-std=gnu++0x --with-system release
cd $VCASH_ROOT

cd coin/test
../../deps/boost/bjam toolset=gcc cxxflags="-std=gnu++0x -fpermissive" release
cd $VCASH_ROOT

cp coin/test/bin/gcc-*/release/link-static/stack /usr/bin/vcashd

else
#################################################################
# Install Vcash from PPA                                      #
#################################################################
    add-apt-repository -y ppa:Vcash/Vcash
    apt-get update
    apt-get install -y Vcash
fi

file=/etc/init.d/vcash

if [ ! -e "$file" ]
then
	printf '%s\n%s\n' '#!/bin/sh' 'nohup vcashd >/dev/null 2>&1 &' | tee /etc/init.d/vcash
	chmod +x /etc/init.d/vcash
	update-rc.d vcash defaults
fi

echo "vcashd is starting..."

nohup /usr/bin/vcashd >/dev/null 2>&1 &

exit 0

