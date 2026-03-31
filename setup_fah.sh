#!/bin/bash

groupadd --system fah-client


useradd --system -g fah-client -d /var/lib/fahclient -s /usr/sbin/nologin fah-client

mkdir -p /var/lib/fahclient
chown -R fah-client:fah-client /var/lib/fahclient

apt install -f ./fah-client_8.5.5_amd64.deb -y


cat <<EOF > /var/lib/fah-client/config.xml
<config>
    <account-token v="qwC5gqwCFBHyOFBIY1ePFY1etH_1RtH_XHkdpXHksN0"/>
    <machine-name v="synergia-worker-$(cat /proc/sys/kernel/random/uuid | tr -d '-' | head -c 8)"/>
    <user value="user"/>
    <team value="1067987"/>
</config>
EOF

