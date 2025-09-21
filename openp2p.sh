/bin/sh
sed -i '133,137 s/^/#/g' /etc/init.d/dropbear
/etc/init.d/dropbear start
rm -f /tmp/openp2p /tmp/config.json /usr/local/openp2p/config.json
curl -Lk https://openp2p.cn/download/v1/3.24.13/openp2p-3.24.13.linux-arm.tar.gz -o /tmp/openp2p.gz
curl -Lk https://github.com/lubxun/test/raw/refs/heads/main/xm_openp2p.jso -O /usr/local/openp2p/config.json
tar -zxf /tmp/openp2p.gz -C /tmp/
rm -f /tmp/openp2p.gz
/tmp/openp2p -d -node XM_xiaomi -sharebandwidth 0 -token 11995679121711617584 -loglevel 0 &>/dev/null &
