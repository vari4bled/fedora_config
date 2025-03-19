#!/bin/bash
#cd to script directory
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
#Username for home folder
read -p 'Username name: ' userName
#give chance to interrupt
sleep 5
#Install packages
sudo dnf update
sudo dnf  -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf  -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install pulseaudio-utils
sudo dnf -y install git
sudo dnf -y install papirus-icon-theme breeze-cursor-theme
sudo dnf -y install util-linux-user
sudo dnf -y install dnf-plugins-core
sudo dnf -y install gstreamer1-plugins-{bad-*,good-*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf -y install mpv mpv-libs
sudo dnf -y install python3-vapoursynth
sudo dnf -y install wireshark
sudo dnf -y install lutris steam
sudo dnf -y install sqlite3
sudo dnf -y install gnome-tweaks
sudo dnf -y install gnome-extensions-app
sudo dnf -y install smplayer
sudo dnf -y install xwaylandvideobridge
sudo dnf -y install openssl
sudo dnf -y install PackageKit gnome-packagekit gnome-packagekit-updater gnome-packagekit-common plymouth
flatpak install signal discord flatseal

#################################################zsh stuff################################################
sudo dnf -y install zsh zsh-autosuggestions zsh-syntax-highlighting
if ! [ -e ~/.local/share/zsh/oh-my-zsh ]; then
  mkdir -p ~/.local/share/zsh/oh-my-zsh
fi
if ! [ -e ~/.local/share/zsh/powerlevel10k ]; then
  mkdir -p ~/.local/share/zsh/powerlevel10k
fi
if ! [ -e ~/.config/zsh ]; then
  mkdir -p ~/.config/zsh
fi
if ! [ -e ~/.fonts ]; then
  mkdir -p ~/.fonts
fi
if ! [ -e ~/.zshrc ]; then
  touch ~/.zshrc
fi
cp ./zsh/* ~/.config/zsh/
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.local/share/zsh/oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/zsh/powerlevel10k
wget -O ~/.fonts/MesloLGS\ NF\ Regular.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
wget -O ~/.fonts/MesloLGS\ NF\ Bold.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
wget -O ~/.fonts/MesloLGS\ NF\ Italic.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
wget -O ~/.fonts/MesloLGS\ NF\ Bold\ Italic.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
echo """
ZSH=$HOME/.local/share/zsh/oh-my-zsh
source $HOME/.config/zsh/zsh-exports
source $HOME/.config/zsh/zsh-aliases
source $HOME/.config/zsh/zsh-plugins
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi
source $ZSH/oh-my-zsh.sh
source ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme
""" | tee -a ~/.zshrc
sudo chsh $userName -s /bin/zsh

####################################################Zsolti workstations##########################################################
#mount nfs drives
echo "192.168.192.99:/home/pi/camera /mnt/camera nfs proto=tcp,noatime,x-systemd.requires=network-online.target,x-systemd.automount,_netdev,user,noauto 0 0"  | sudo tee -a /etc/fstab
echo "192.168.192.99:/home/pi/Torrent/Data/Finished /mnt/nfs nfs proto=tcp,noatime,x-systemd.requires=network-online.target,x-systemd.automount,_netdev,user,noauto 0 0" | sudo tee -a /etc/fstab
cp ./ffbg* ~/.config/systemd/user/
cp ./audiocaffeine.service ~/.config/systemd/user/
cp ./bingcopier.sh ~/.local/bin/
cp ./audiocaffeinev2.sh ~/.local/bin/
cp ./audiocaffeinev2loop.sh ~/.local/bin/
systemctl --user daemon-reload
systemctl --user enable ffbg.timer
systemctl --user enable audiocaffeine.service
#about:config enable  toolkit.legacyUserProfileCustomizations.stylesheets
mozzillaFolderGuess= $ (find ~/.mozilla/firefox/ -maxdepth 1 -type d  -printf '%T@ %p\n' | grep -v "Crash\|Pending" | sort -k1,1nr | head -1 | awk  '{print $2}')
if [[ $mozzillaFolderGuess == *"default-release"* ]]; then
   if ! [ -e $mozzillaFolderGuess/chrome/img ]; then
    mkdir -p $mozzillaFolderGuess/chrome/img
 fi
fi
if [[ $(  find ~/.mozilla/firefox/ -maxdepth 1 -type d  -printf '%T@ %p\n' | grep -v "Crash\|Pending" | sort -k1,1nr | head -1 | awk  '{print $2}') == *"default-release"* ]]; then
 if ! [ -e $(  find ~/.mozilla/firefox/ -maxdepth 1 -type d  -printf '%T@ %p\n' | grep -v "Crash\|Pending" | sort -k1,1nr | head -1 | awk  '{print $2}')/chrome/img ]; then
    mkdir -p $(  find ~/.mozilla/firefox/ -maxdepth 1 -type d  -printf '%T@ %p\n' | grep -v "Crash\|Pending" | sort -k1,1nr | head -1 | awk  '{print $2}')/chrome/img
 fi
 if ! [ -e $(  find ~/.mozilla/firefox/ -maxdepth 1 -type d  -printf '%T@ %p\n' | grep -v "Crash\|Pending" | sort -k1,1nr | head -1 | awk  '{print $2}')/chrome/userContent.css ]; then
  echo  """@-moz-document url(about:home), url(about:newtab), url(about:privatebrowsing) {
    .click-target-container *, .top-sites-list * {
        color: #fff !important ;
        text-shadow: 2px 2px 2px #222 !important ;
    }

    body::before {
        content: \"\" ;
        z-index: -1 ;
        position: fixed ;
        top: 0 ;
        left: 0 ;
        background: #f9a no-repeat url(img/background.png) center ;
        background-size: cover ;
        width: 100vw ;
        height: 100vh ;
    }
}
    """ >> $(  find ~/.mozilla/firefox/ -maxdepth 1 -type d  -printf '%T@ %p\n' | grep -v "Crash\|Pending" | sort -k1,1nr | head -1 | awk  '{print $2}')/chrome/userContent.css
 fi
fi
#fix gnome session to take environment variables
sudo sed -i 's@#!/bin/sh@#!/bin/sh -l@' /bin/gnome-session
#environment variables for AMD guys
echo 'STEAM_FORCE_DESKTOPUI_SCALING="1.5"' | sudo tee -a /etc/environment
echo "RUSTICL_ENABLE=radeonsi" | sudo tee -a /etc/environment

#OpenCL wonder if this still works?
#git clone https://github.com/sukhmeetbawa/OpenCL-AMD-Fedora.git
#cd ./OpenCL-AMD-Fedora
#./opencl-amd.sh

######################################################System settings###########################################################

sudo systemctl start sshd
sudo systemctl enable sshd
#some handy stuff
sudo touch /etc/sudoers.d/$userName
echo "$userName   ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$userName
#mitigations and orphan process crash timeout
sudo sed -i '1s/^/quiet splash mitigations=off /' /etc/kernel/cmdline
sudo sed -i 's@#DefaultTimeoutStopSec=90s@DefaultTimeoutStopSec=15s@' /etc/systemd/system.conf
#fck selinux
sudo sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/selinux/config
sudo sed -i '/^#SELINUX=/c\SELINUX=disabled' /etc/selinux/config
#systemd-bootd timeout
sudo sed -i 's@timeout 5@timeout 0@' /efi/loader/loader.conf
#suspend-then-hibernate enable, make sure resume is set as a kernel parameter with a swap partition or file
#zram won't work with resume
sudo ln -s /usr/lib/systemd/system/systemd-suspend-then-hibernate.service /etc/systemd/system/systemd-suspend.service
sudo sed -i '/AllowSuspendThenHibernate=/c\AllowSuspendThenHibernate=yes' /etc/systemd/sleep.conf
sudo sed -i '/HibernateState=/c\HibernateState=disk' /etc/systemd/sleep.conf
sudo sed -i '/HibernateDelaySec=/c\HibernateDelaySec=30min' /etc/systemd/sleep.conf
####################################################autoupdate#################################################################
if ! [ -e ~/.local/bin/ ]; then
  mkdir -p ~/.local/bin/
fi
cp ./fedora-updater* ~/.local/bin/
cp ./dnf-autoupdate* ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable dnf-autoupdate-refresh.timer 
systemctl --user enable dnf-autoupdate-update.timer
systemctl --user start dnf-autoupdate-refresh.timer 
systemctl --user start dnf-autoupdate-update.timer

