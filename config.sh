# Update the system and install basic utils
sudo apt update
sudo apt upgrade -y
sudo apt install zip unzip tree build-essential -y


# Install and config ZSH with Oh My ZSH
sudo apt install zsh -y
echo 'y' | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i 's/git)/git zsh-syntax-highlighting)/' .zshrc


# Install NVM and Node LTS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
tail -n 3 .bashrc >> .zshrc
source .bashrc
nvm install --lts

# Install SDKMAN and Java 17-LTS
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 17


# Install Pyenv and Python
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
tail -n 3 .bashrc >> .zshrc
source .bashrc
pyenv install 3.12.0
pyenv global 3.12.0


# Install Docker Engine
## Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
## Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
## Install packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
## Add user to docker group
sudo usermod -aG docker $USER
newgrp docker


# Install NeoVim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
mkdir ~/appimages
rm -rf ~/.nvim.appimage
sudo mv squashfs-root/ ~/appimages/nvim/
sudo ln -s $HOME/appimages/nvim/AppRun /usr/bin/nvim
