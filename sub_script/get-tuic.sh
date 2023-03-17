#!/bin/bash
echo "Start install tuic"
sleep 1s

VER="0.8.5"
TUIC_DIR="/root/tuic"

# Delete tuic may exist
rm ${TUIC_DIR} -r >>/dev/null 2>&1
mkdir ${TUIC_DIR} && cd ${TUIC_DIR} >>/dev/null 2>&1
wget https://github.com/EAimTY/tuic/releases/download/${VER}/tuic-server-${VER}-x86_64-linux-gnu >>/dev/null 2>&1
chmod +x tuic-server-${VER}-x86_64-linux-gnu >>/dev/null 2>&1

# Create node info
tuicToken=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)
read -p "(type port)：" tuicPort
read -p "(type cert path)：" certPath
read -p "(type cert host)：" certHost

# Create tuic config
cat >${TUIC_DIR}/config.json <<-EOF
{
    "port": $tuicPort,
    "token": ["${tuicToken}"],
    "certificate": "${certPath}/${certHost}.crt",
    "private_key": "${certPath}/${certHost}.key",
    "ip": "0.0.0.0",
    "congestion_controller": "bbr",
    "alpn": ["h3"]
}
EOF

# Create tuic service
cat >${TUIC_DIR}/tuic.service <<-EOF
[Unit]
Description=Delicately-TUICed high-performance proxy built on top of the QUIC protocol
Documentation=https://github.com/EAimTY/tuic
After=network.target

[Service]
User=root
WorkingDirectory=/opt/tuic
ExecStart=/opt/tuic/tuic-server-${VER}-x86_64-linux-gnu -c config.json
Restart=on-failure
RestartSec=7s
RestartPreventExitStatus=1
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# nvim config.json
rm /lib/systemd/system/tuic.service >>/dev/null 2>&1
rm /opt/tuic -r >>/dev/null 2>&1
ln -s ${TUIC_DIR}/tuic.service /lib/systemd/system >>/dev/null 2>&1
ln -s ${TUIC_DIR} /opt >>/dev/null 2>&1
systemctl enable tuic.service
systemctl start tuic.service

# echo node info
echo "================= node info ================="
checkIP=$(curl -s http://ifconfig.io)
echo "       ip = $checkIP"
echo "     port = $tuicPort"
echo "    token = $tuicToken"
echo "============================================="
echo " Plz check node infomation"
echo "finished, type <enter> continue"
read none
