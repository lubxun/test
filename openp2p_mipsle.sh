#!/bin/sh
rm -rf /tmp/openp2p* /tmp/config.json /usr/local/openp2p
curl -Lk https://raw.githubusercontent.com/lubxun/test/refs/heads/main/xn_openp2p.json -o /tmp/config.json
#mkdir -p /usr/local/openp2p
#rm -f /tmp/config.json
if [ -f /media/AiDisk_a1/openp2p ]
  then
    /media/AiDisk_a1/openp2p -d -node XINAN_pdcn -sharebandwidth 0 -token 11995679121711617584 -loglevel 3 &>/dev/null &
    exit
fi
curl -Lk https://github.com/openp2p-cn/openp2p/releases/download/v3.25.11/openp2p-3.25.11.linux-mipsle.tar.gz -o /tmp/openp2p.gz
tar -zxf /tmp/openp2p.gz -C /tmp/
rm -f /tmp/openp2p.gz
/tmp/openp2p -d -node EF_pdcn -sharebandwidth 0 -token 11995679121711617584 -loglevel 3 &>/dev/null &
