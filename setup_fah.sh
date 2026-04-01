#!/bin/bash

git clone https://github.com/cauldrondevelopmentllc/cbang
git clone https://github.com/foldingathome/fah-client-bastet
export CBANG_HOME=$PWD/cbang
scons -C cbang
scons -C fah-client-bastet
