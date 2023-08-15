#!/bin/bash
echo "Start install snell (v4)"
sleep 1s

SNELL_DIR="/root/snell"
VER="4.0.1"
ARCH="$(dpkg --print-architecture)"

# Install unzip
echo "Y\n" | apt install unzip

# Prepare dir and file
rm ${SNELL_DIR} -r >>/dev/null 2>&1
mkdir ${SNELL_DIR} && cd ${SNELL_DIR} >>/dev/null 2>&1
wget https://dl.nssurge.com/snell/snell-server-v${VER}-linux-${ARCH}.zip >>/dev/null 2>&1
unzip snell-server-v${VER}-linux-${ARCH}.zip >>/dev/null 2>&1
rm snell-server-v${VER}-linux-${ARCH}.zip >>/dev/null 2>&1
chmod +x snell-server >>/dev/null 2>&1
echo "Y\n" | ${SNELL_DIR}/snell-server >>/dev/null 2>&1
echo "obfs = http" >>${SNELL_DIR}/snell-server.conf
echo "tfo = true" >>${SNELL_DIR}/snell-server.conf

# Create snell config
cat >${SNELL_DIR}/snell.service <<-EOF
[Unit]
Description=Snell Proxy Service
After=network.target

[Service]
Type=simple
User=nobody
Group=nogroup
LimitNOFILE=32768
# ExecStart=/usr/bin/proxychains4 /usr/local/bin/snell-server -c /etc/snell-server.conf
ExecStart=/usr/local/bin/snell-server -c /etc/snell-server.conf
Restart=on-failure
RestartSec=7s
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=snell-server

[Install]
WantedBy=multi-user.target
EOF

echo "snell file preparing"
rm /etc/snell-server.conf >>/dev/null 2>&1
rm /usr/local/bin/snell-server >>/dev/null 2>&1
rm /lib/systemd/system/snell.service >>/dev/null 2>&1
mv ${SNELL_DIR}/snell-server.conf /etc >>/dev/null 2>&1
mv ${SNELL_DIR}/snell-server /usr/local/bin >>/dev/null 2>&1
mv ${SNELL_DIR}/snell.service /lib/systemd/system >>/dev/null 2>&1
systemctl enable snell.service
systemctl retart snell.service

echo "================= node info ================="
checkIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo "       ip = $checkIP"
echo "     port = $(cat ${SNELL_DIR}/snell-server.conf | grep ':' | awk -F ':' '{print $NF}')"
echo "      psk = $(cat ${SNELL_DIR}/snell-server.conf | grep 'psk = ' | awk -F 'psk = ' '{print $NF}')"
echo "     obfs = $(cat ${SNELL_DIR}/snell-server.conf | grep 'obfs = ' | awk -F 'obfs = ' '{print $NF}')"
echo "      tfo = $(cat ${SNELL_DIR}/snell-server.conf | grep 'tfo = ' | awk -F 'tfo = ' '{print $NF}')"
echo "============================================="
echo " Plz check node infomation"
echo "finished, type <enter> continue"
read none

echo "================= Cleaning File ================="
rm -rf ${SNELL_DIR}
