#!/bin/bash
# 环境安装脚本（测试）

apt() {
	clear
	/usr/bin/apt update >>/dev/null 2>&1
	echo "install: zsh curl git neovim rclone unzip p7zip-full npm"
	echo "Y\n" | /usr/bin/apt install zsh curl git neovim rclone unzip p7zip-full npm -y >>/dev/null 2>&1
	echo "finished, type <enter> continue"
	read none
	sleep 3s
	mainMenu
}

ohmyzsh() {
	clear
	wget https://github.com/xsnaruto/something/raw/main/sub_script/get-zsh.sh
	bash get-zsh.sh
	rm get-zsh.sh
	sleep 1s
	mainMenu
}

neovim() {
	clear
	wget https://github.com/xsnaruto/something/raw/main/sub_script/get-nvim.sh
	bash get-nvim.sh
	rm get-nvim.sh
	sleep 1s
	mainMenu
}

other() {
	clear
	echo -e "      other operation"
	echo -e "============================="
	echo -e "1. tcpx"
	echo -e "2. swap"
	echo -e "3. snell"
	echo -e "4. tuic"
	echo -e "9. quit"
	echo -e "============================="
	echo -n "choose operation: "
	read option

	clear
	case "$option" in
	"tcpx")
		wget https://github.com/xsnaruto/something/raw/main/sub_script/get-tcpx.sh
		bash get-tcpx.sh && rm get-tcpx.sh
		;;
	"swap")
		echo "currently mem is: $(free -m | grep Mem | awk '{print $2}')mb"
		echo -n "type enter 2 continue"
		wget https://github.com/xsnaruto/something/raw/main/sub_script/get-swap.sh
		bash get-swap.sh && rm get-swap.sh
		;;
	"snell")
		wget https://github.com/xsnaruto/something/raw/main/sub_script/get-snell.sh
		bash get-snell.sh && rm get-snell.sh
		;;
	"tuic")
		wget https://github.com/xsnaruto/something/raw/main/sub_script/get-tuic.sh
		bash get-tuic.sh && rm get-tuic.sh
		;;
	"quit")
		mainMenu
		;;
	*)
		echo -n "error input, try again"
		;;
	esac

	sleep 1s
	other
}

rclone() {
	clear
	echo -e "      rclone operation"
	echo -e "============================="
	echo -e "1. install"
	echo -e "2. config"
	echo -e "3. quit"
	echo -e "============================="
	echo -n "choose operation: "
	read option
	case "$option" in
	"install")
		echo -n "rclone installing"
		echo "Y\n" | apt install rclone >>/dev/null 2>&1
		rm -rf ~/.config/rclone
		mkdir ~/.config/rclone -p
		echo -n "rclone installed"
		;;
	"config")
		/usr/bin/rclone config
		clear
		echo -n "rclone config finished"
		;;
	"quit")
		mainMenu
		;;
	*)
		echo -n "error input, try again"
		;;
	esac

	sleep 2s
	rclone
}

nginx() {
	clear
	echo -e "       nginx operation"
	echo -e "============================="
	echo -e "1. install"
	echo -e "2. cert"
	echo -e "3. config"
	echo -e "4. quit"
	echo -e "============================="
	echo -n "choose operation: "
	read option
	case "$option" in
	"install")
		clear
		echo -e "       nginx package"
		echo -e "============================="
		echo -e "1. apt (based version)"
		echo -e "2. deb (h3 & brotli)"
		echo -e "3. script (compile)"
		echo -e "4. quit"
		echo -e "============================="
		echo -n "choose operation: "
		read install_option
		case "$install_option" in
		"apt")
			clear
			echo "nginx installing"
			echo "Y\n" | /usr/bin/apt install nginx >>/dev/null 2>&1
			echo "nginx installed"
			sleep 3s
			nginx
			;;
		"deb")
			clear
			echo "source from https://github.com/ononoki1/nginx-http3#features"
			echo "nginx install start"
			echo -n "type any key to continue"
			read
			wget https://github.com/ononoki1/nginx-http3/releases/latest/download/nginx.deb >>/dev/null 2>&1
			dpkg -i nginx.deb >>/dev/null 2>&1
			rm nginx.deb >>/dev/null 2>&1
			echo "nginx installed"
			sleep 3s
			nginx
			;;
		"script")
			clear
			echo "source from https://github.com/angristan/nginx-autoinstall"
			echo "nginx install start"
			echo -n "type any key to continue"
			read
			wget https://github.com/angristan/nginx-autoinstall/raw/master/nginx-autoinstall.sh >>/dev/null 2>&1
			chmod +x nginx-autoinstall.sh && bash nginx-autoinstall.sh
			echo "nginx installed"
			sleep 3s
			nginx
			;;
		"quit")
			nginx
			;;
		*)
			echo -n "error input, try again"
			sleep 2s
			echo "install\n" | nginx
			;;
		esac
		nginx
		;;
	"cert")
		echo "certs files syncing"
		/usr/bin/rclone copy dropbox:'Backups'/'ImWc.Me'/certs /etc/nginx/certs --exclude "double-check/"
		sleep 3s
		echo "certs files synced"
		sleep 1s
		nginx
		;;
	"quit")
		mainMenu
		;;
	*)
		echo "error input, try again"
		sleep 2s
		nginx
		;;
	esac
}

crontab() {
	case $option in
	"certs")
		echo "# Sync certs" >>/etc/crontab >>/dev/null 2>&1
		echo "0 0 * * * rclone sync /etc/nginx/certs dropbox:Backups/ImWc.Me/certs && systemctl restart nginx" >>/etc/crontab >>/dev/null 2>&1
		;;
	"other")
		echo "# Backup docker files" >>/etc/crontab >>/dev/null 2>&1
		;;
	esac
}

docker() {
	# Install docker
	echo "Y\n" | /usr/bin/apt install docker.io >>/dev/null 2>&1

	# Project files info
	read -p "cloud service:" cloudService
	read -p "cloud path:" cloudPath
	read -p "local path:" localPath
	mkdir ${localPath} -p >>/dev/null 2>&1

	dockerProject() {
		# Choose project
		read -p "choose project <bitwarden><tautulli><blog><twikoo><api>:" projectName
		case "$projectName" in
		"bitwarden")
			# Copy files to local
			rclone copy ${cloudService}:${cloudPath}/bitwarden ${localPath}/bitwarden
			# Deploy & start service
			cd ${localPath}/bitwarden && docker-compose up -d
			# Create cron to sync data
			echo "\n# Bitwarden backup (Every hour)\n0 * * * * /usr/bin/rclone sync ${localPath}/bitwarden ${cloudService}:${cloudPath}/bitwarden --exclude \"{icon_cache}/**\"\n" >>/var/spool/cron/crontabs/root
			echo "bitwarden-server installed"
			;;
		"tautulli")
			# Copy files to local
			rclone copy ${cloudService}:${cloudPath}/tautulli ${localPath}/tautulli
			# Deploy & start service
			cd ${localPath}/tautulli && docker-compose up -d
			# Create cron to sync data
			echo "\n# Tautulli backup (Every 12 hour)\n59 */12 * * * /usr/bin/rclone sync ${localPath}/bitwarden ${cloudService}:${cloudPath}/bitwarden --exclude \"{icon_cache}/**\"\n" >>/var/spool/cron/crontabs/root
			echo "tautulli-server installed"
			;;
		"blog")
			/usr/bin/docker pull ghost:latest
			/usr/bin/docker stop ghost-blog
			/usr/bin/docker rm ghost-blog
			/usr/bin/docker run -d --name ghost-blog --restart always -p 32401:2368 -e host=https://imwc.me -v /www/docker/ghost/content/imwc.me:/var/lib/ghost ghost:latest
			echo "y\n" | /usr/bin/docker system prune >>/dev/null 2>&1
			echo "ghost-blog installed"
			;;
		"twikoo")
			echo "twikoo-server installed"
			;;
		"api")
			/usr/bin/docker pull php:7.4.20-apache
			/usr/bin/docker stop api-server
			/usr/bin/docker rm api-server
			/usr/bin/docker run -d --name api-service --restart always -v /www/docker/php-apache/api.imwc.me:/var/www/html -e VIRTUAL_HOST='api.imwc.me' -e VIRTUAL_PORT=80 -p 32401:80 -e HTTPS_METHOD=noredirect -e CERT_NAME=imwc.me php:7.4.20-apache
			echo "y\n" | /usr/bin/docker system prune >>/dev/null 2>&1
			echo "api-server installed"
			;;
		"quit")
			service cron reload
			wait 1s
			quit
			;;
		*)
			echo -n "error input, try again"
			sleep 1
			dockerProject
			;;
		esac
	}
}

quit() {
	/bin/zsh -i
}

mainMenu() {
	clear
	echo -e "\tPersonal env. setting script\t"
	echo "==================core-env=================="
	echo -e "1. \e[1;32menv\e[0m\t\t\t2. \e[1;32mohmyzsh\e[0m"
	echo -e "3. \e[1;32mneovim\e[0m\t\t4. \e[1;32mother\e[0m"
	echo "==================optn-env=================="
	echo -e "5. \e[1;34mrclone\e[0m\t\t6. \e[1;34mnginx\e[0m"
	echo -e "7. \e[1;31mcrontab\e[0m\t\t8. \e[1;31mdocker\e[0m"
	echo "============================================"
	echo "9. quit (Auto switch to zsh)"
	echo "============================================"
	echo -n "type name of options (not num): "
	read option

	case "$option" in
	"env")
		apt
		;;
	"ohmyzsh")
		ohmyzsh
		;;
	"neovim")
		neovim
		;;
	"other")
		other
		;;
	"rclone")
		rclone
		;;
	"nginx")
		nginx
		;;
	"crontab")
		rclone
		;;
	"quit")
		quit
		;;
	*)
		echo -n "error input, try again"
		sleep 1
		mainMenu
		;;
	esac
}

mainMenu
