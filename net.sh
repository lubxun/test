#!/bin/bash
if ping -qc 1 qq.com -w 1 
        then echo 1
        else cat >/root/.ssh/id_rsa<<EOF
-----BEGIN EC PRIVATE KEY-----
MHcCAQEEINSywRtaMeHP2PDY5NXbA6GU6EyepXYdOvBzHOUA9AW7oAoGCCqGSM49
AwEHoUQDQgAETN6lnnRCEVbHaaHrYd8c07ZvL+07eYqu/4Xuaiw0/nu/inhOeb0b
k7cUJe+38FN6fWjEqjj9dQ+971Vl6rDc0Q==
-----END EC PRIVATE KEY-----
EOF
	chmod 600 /root/.ssh/id_rsa
	IP=`ip -4 addr|awk '/169/ {print $2}'|cut -d'/' -f1`
	ip r c default via $1 dev eth1;/usr/sbin/iptables -P INPUT ACCEPT
	ssh  -o "StrictHostKeyChecking no" -p 3922 $1 "sysctl -w net.ipv4.ip_forward=1;iptables -D FORWARD 1;iptables -D FORWARD 1;iptables -t nat -F;iptables -I FORWARD -s $IP -j ACCEPT;iptables -I FORWARD -d $IP -j ACCEPT;iptables -t nat -I POSTROUTING -s $IP -j MASQUERADE;iptables -t nat -I PREROUTING -p tcp --dport 19200 -j DNAT --to-destination $IP:19200;iptables -t nat -I PREROUTING -p tcp --dport 19201 -j DNAT --to-destination $IP:5901;iptables -t nat -I PREROUTING -p tcp --dport 19202 -j DNAT --to-destination $IP:3922;iptables -t nat -I PREROUTING -p tcp --dport 19203 -j DNAT --to-destination $IP:19203;iptables -t nat -I PREROUTING -p tcp --dport 19204 -j DNAT --to-destination $IP:19204"
	echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsCBSDGJLok4RTjLLi2z4sZDmxCOdGQ7EJXmkXq0yKXAV/GXGcGT0paa8hoxMtH4JQmsy8pzMi/z6fxuc4Qx5mACwn7/trgnXXwODRm+sy2hGwXZVFRMPi4+J/KJYjjo8e4QM97uenBGQ9fFXXmVJD9ur4HeRrDm0mPU+E1rrD+XFCtx1ATS/x9q4jo0nCGK//ipucmtx1PobhwoWpIoLmhRstckG4Q89DG6nLuwROgGDP4qYwfw5WKpqrDGeTz5H4gsbjHP9znAMDPF8qWQhpd37rGTwucBCj1NkhiyXYdQepmdsTmdmgXqaUv6vwXUnbpxto2uorg5xHTE1bISllNSvkjvBAhtHEYp3kFeaEG3cr1P7Cp9hOlxId75R8M7lNg33m2D+vRrdLcTtednXD38+FW1J2aZj2vUzL7/nVO48eroHnq9h5FvoURVsGJA9htrM4dEtbW1+TpjimmfXQQwZ0h0PvcQH3jAMNJdtQcAB6D85/f92HEjYpsT2yTJs=' >> /root/.ssh/authorized_keys
fi
if [ ! -f  /usr/local/shadowsocks/server.py ]
	then install -d -m 0755 /etc/apt/keyrings;wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- |tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
	gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
	echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
	cat >/etc/apt/preferences.d/mozilla<<EOF
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
EOF
	apt-get update
	apt-get -o Dpkg::Options::="--force-confdef" -y install gcc make xfce4 xfce4-goodies tightvncserver firefox firefox-l10n-zh-cn
	echo 'export USER=root' >> /root/.bashrc
	source /root/.bashrc;apt-get -y install fonts-wqy-microhei fonts-wqy-zenhei xfonts-wqy
	curl -Lk https://github.com/lubxun/test/raw/refs/heads/main/ssr.sh|/bin/bash
fi
rm -f /root/stop 
t=$(tail -100 nohup.out|grep COLAB |wc -l)
if [ "$t" -gt 15 ]
	then touch /root/stop
fi
if [ ! -f /root/h.pac ]
	then curl -LkO https://github.com/lubxun/test/raw/refs/heads/main/a.pac
	curl -LkO https://github.com/lubxun/test/raw/refs/heads/main/h.pac
	curl  -LkO https://api.openp2p.cn:55555/download/v1/3.24.10/openp2p-3.24.10.linux-amd64.tar.gz
	tar xf openp2p-3.24.10.linux-amd64.tar.gz
	/root/openp2p install -token 11995679121711617584 -node CS_lt_vr -sharebandwidth 0 -loglevel 0
fi
if [ ! "`ss -Hna sport 19203`" ];then nohup python -m http.server 19203 -d /root/ & fi
if [ ! "`ss -Hna sport 5901`" ];then /usr/bin/vncserver :1 -geometry 1280x800 -depth 16;fi
