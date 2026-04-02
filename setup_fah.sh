#!/bin/bash

wget https://download.foldingathome.org/releases/public/fah-client/debian-10-64bit/release/fah-client_8.5.5_amd64.deb
dpkg-deb -x fah-client_8.5.5_amd64.deb ./fah
