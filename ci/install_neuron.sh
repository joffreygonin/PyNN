#!/bin/bash

set -e  # stop execution in case of errors

export NRN_VERSION="nrn-7.4"
if [ ! -f "$HOME/$NRN_VERSION/configure" ]; then
    wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/$NRN_VERSION.tar.gz -O $HOME/$NRN_VERSION.tar.gz;
    pushd $HOME;
    tar xzf $NRN_VERSION.tar.gz;
    popd;
else
    echo 'Using cached version of NEURON sources.';
fi
mkdir -p $HOME/build/$NRN_VERSION
pushd $HOME/build/$NRN_VERSION
if [ ! -f "$HOME/build/$NRN_VERSION/config.log" ]; then
    export VENV=`python -c "import sys; print sys.prefix"`;
    $HOME/$NRN_VERSION/configure --with-paranrn --with-nrnpython --prefix=$VENV --without-iv;
    make;
else
    echo 'Using cached NEURON build directory.';
fi
make install
cd src/nrnpython
python setup.py install
popd