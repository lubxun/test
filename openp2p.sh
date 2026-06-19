#!/bin/sh
sed -i '133,137 s/^/#/g' /etc/init.d/dropbear
/etc/init.d/dropbear start
rm -rf /tmp/openp2p* /tmp/config.json /usr/local/openp2p
#mkdir -p /usr/local/openp2p
curl -Lk https://github.com/openp2p-cn/openp2p/releases/download/v3.25.11/openp2p-3.25.11.linux-arm.tar.gz -o /tmp/openp2p.gz
tar -zxf /tmp/openp2p.gz -C /tmp/
rm -f /tmp/config.json
curl -Lk https://raw.githubusercontent.com/lubxun/test/refs/heads/main/xm_openp2p.json -o /tmp/config.json
rm -f /tmp/openp2p.gz
/tmp/openp2p -d -node XM_xiaomi -sharebandwidth 0 -token 11995679121711617584 -loglevel 3 &>/dev/null &
