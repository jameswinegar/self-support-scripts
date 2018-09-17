# Initial update of system
sudo apt update
sudo apt upgrade -y

# install libsecret
sudo apt install -y libsecret-1-0 libsecret-1-dev
(cd /usr/share/doc/git/contrib/credential/libsecret && sudo make)

# set git email
git config --global user.email "jameswine@gmail.com"
git config --global user.name "jameswinegar"
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

# move dotfiles
cp dotfiles/.bash_aliases ${HOME}

# enable locate
sudo ionice -c3 updatedb

# install sqlite
sudo apt install -y sqlite

#install python and pipenv
sudo apt install python-pip python3-pip
pip3 install --user pipenv
echo 'export PATH="${HOME}/.local/bin:$PATH"' >> ${HOME}/.bashrc
source ${HOME}/.bashrc

# install snap and install what can be done through snaps
sudo apt install -y snapd
sudo snap install slack --classic
sudo snap install pycharm-professional --classic
sudo snap install discord
sudo snap install spotify

# install cuda
sudo apt install -y nvidia-cuda-toolkit gcc-6

# install google chrome
wget -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install /tmp/google-chrome.deb -y

# install docker
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install docker-ce

# install gcloud and kubectl
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt update
sudo apt install -y google-cloud-sdk
sudo apt install -y kubectl

# add systems monitor to task bar
sudo apt install -y gnome-shell-extension gir1.2-gtop-2.0 gir1.2-networkmanager-1.0  gir1.2-clutter-1.0
sudo wget -O /usr/local/bin/gnomeshell-extension-manage "https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage"
sudo chmod +x /usr/local/bin/gnomeshell-extension-manage
gnomeshell-extension-manage --install --extension-id 120

# add Hashicorp service updater. TODO: Only update when needed, currently downloads on each init of systemd
sudo ./publisher.sh

# Remind me to do stuff
printf '\n\n\n\n\n\n'
echo "DO THE FOLLOWING:"
echo "1. Add slack channels"
echo "2. Add google accounts"
echo "3. Initalize gcloud cli"
echo "4. Setup PyCharm"
echo "5. Login to spotify & discord"
