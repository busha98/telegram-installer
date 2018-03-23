#!/bin/bash

echo "============================================="
echo "==     Telegram Script Installer           =="
echo "==                                         =="
echo "==      for www.LinuxRussia.com            =="
echo "============================================="

echo "Downloading necesary files..."
cd /tmp
wget -O - https://tdesktop.com/linux > tsetup.tar.xz

echo "Extracting files..."
tar -xJvf tsetup.tar.xz

echo "Checking destination folder..."
installdir="$HOME/.apps/telegram"
echo "Checking apps folder..."
appsfolder="$HOME/.apps"
if [ ! -d $appsfolder ]; then
	mkdir $HOME/.apps
	echo "Created ${appsfolder}"
elif [ -d $installdir ]; then
	rm -r $installdir
	echo "Removed old ${installdir}"
else
	echo "${installdir} is not exists...moving on"
fi

mv Telegram $installdir
echo "Moved new files to ${installdir}"

echo "Checking duplicating shortcut files"
telegramdesktop="$HOME/.local/share/applications/telegramdesktop.desktop" 
if [ -f $telegramdesktop ]; then
	sudo rm $telegramdesktop
	echo "Removed old shortcut: ${telegramdesktop}"
else
	echo "${telegramdesktop} is not exists...moving on"
fi

echo "Checking old config"
old_data="$HOME/.local/share/TelegramDesktop"
if [ -d ${old_data} ]; then
	sudo rm -r ${old_data}
	echo "Removed old config data: ${old_data}"
else
	echo "${old_data} is not exists...moving on"
fi

rm /tmp/tsetup.tar.xz
echo "Removed tmp files..."

echo "Checking old Telegram installation in /opt and removing it"
old_installdir="/opt/telegram"
if [ -d $old_installdir ];then
	sudo rm -r $old_installdir
	echo "Removed old installation ${old_installdir}"
else
	echo "${old_installdir} is not exists...moving on"
fi

echo "Installation Complete! Launching Telegram for initial configuration"
$installdir/Updater > /dev/null 2>&1 &
