#!/bin/bash

sudo apt update
sudo apt -y install vim

######################### Node  NPM Yarn #########################
# init
sudo apt install nodejs
# setup
[ ! -d ~/.npm-global ] && mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
updpath='export PATH=~/.npm-global/bin:$PATH'
respath=$(cat ~/.profile | grep "$updpath")
[ -z "$respath" ] && echo "$updpath" >> ~/.profile
source ~/.profile
sudo npm install npm --global
sudo chown -R david /home/david/.npm-global
npm install yarn --global

############################## Yarn ##############################
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
if [ ! -f /etc/apt/sources.list.d/yarn.list ]; then
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
fi
sudo apt-get update && sudo apt-get install -y yarn

############################# dbeaver #############################
wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -
if [ ! -f /etc/apt/sources.list.d/dbeaver.list ]; then
    echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
fi
sudo apt-get update && sudo apt-get install -y dbeaver-ce

############################# VSCode #############################
# init
sudo apt-get -y install curl
# setup
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
if [ ! -f /etc/apt/sources.list.d/vscode.list ]; then
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
fi
sudo apt-get -y install apt-transport-https
sudo apt-get update
sudo apt-get -y install code # or code-insiders
# config
code --install-extension dbaeumer.vscode-eslint
code --install-extension donjayamanne.githistory
code --install-extension hollowtree.vue-snippets
code --install-extension ms-python.python
code --install-extension ritwickdey.LiveServer
# clean
rm microsoft.gpg
############################# VSCode #############################


############################# ProtonVPN #############################
########  https://protonvpn.com/support/linux-vpn-tool/ #############
# init
sudo apt-get -y install openvpn
sudo apt-get -y install dialog
sudo apt-get -y install python
sudo apt-get -y install wget
# setup
sudo wget -O protonvpn-cli.sh https://raw.githubusercontent.com/ProtonVPN/protonvpn-cli/master/protonvpn-cli.sh
sudo chmod +x protonvpn-cli.sh
sudo ./protonvpn-cli.sh --install
# config
sudo protonvpn-cli --init
# clean
sudo rm ./protonvpn-cli.sh
############################# ProtonVPN #############################

