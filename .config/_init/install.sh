#!/bin/zsh
#
# This is a shorter modified version of this script
# https://github.com/donnybrilliant/install.sh/blob/main/install.sh
# ==============================================================================

source ./config

# COLOR
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

#########
# Start #
#########

clear
echo " _           _        _ _       _     "
echo "(_)         | |      | | |     | |    "
echo " _ _ __  ___| |_ __ _| | |  ___| |__  "
echo "| | |_ \/ __| __/ _  | | | / __| |_ \ "
echo "| | | | \__ \ || (_| | | |_\__ \ | | |"
echo "|_|_| |_|___/\__\__,_|_|_(_)___/_| |_|"
echo
echo
echo Enter root password

# Ask for the administrator password upfront.
sudo -v

# Keep Sudo until script is finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Install Rosetta
sudo softwareupdate --install-rosetta --agree-to-license

# Install Homebrew
echo
echo "${GREEN}Installing Homebrew"
echo
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Immediately evaluate the Homebrew environment settings for the current session
eval "$(/opt/homebrew/bin/brew shellenv)"

# Check installation and update
echo
echo "${GREEN}Checking installation.."
echo
brew update && brew doctor
export HOMEBREW_NO_INSTALL_CLEANUP=1

# If no Brewfile is present, continue with the default installation
# Install Casks and Formulae
echo
echo "${GREEN}Installing formulae..."
for formula in "${FORMULAE[@]}"; do
brew install "$formula"
if [ $? -ne 0 ]; then
    echo "${RED}Failed to install $formula. Continuing...${NC}"
fi
done

echo "${GREEN}Installing casks..."
for cask in "${CASKS[@]}"; do
brew install --cask "$cask"
if [ $? -ne 0 ]; then
    echo "${RED}Failed to install $cask. Continuing...${NC}"
fi
done

# App Store
echo
echo -n "${RED}Install apps from App Store? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
brew install mas
for app in "${APPSTORE[@]}"; do
    eval "mas install $app"
done
fi

# Cleanup
echo
echo "${GREEN}Cleaning up..."
brew update && brew upgrade && brew cleanup && brew doctor
mkdir -p ~/Library/LaunchAgents
brew tap homebrew/autoupdate
brew autoupdate start $HOMEBREW_UPDATE_FREQUENCY --upgrade --cleanup --immediate --sudo

# Settings
echo
echo -n "${RED}Configure default system settings? ${NC}[Y/n]"
read REPLY
if [[ -z $REPLY || $REPLY =~ ^[Yy]$ ]]; then
  echo "${GREEN}Configuring default settings..."
  for setting in "${SETTINGS[@]}"; do
    eval $setting
  done
fi

# Dock settings
echo
echo -n "${RED}Apply Dock settings?? ${NC}[y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install dockutil
  # Handle replacements
  for item in "${DOCK_REPLACE[@]}"; do
    IFS="|" read -r add_app replace_app <<<"$item"
    dockutil --add "$add_app" --replacing "$replace_app" &>/dev/null
  done
  # Handle additions
  for app in "${DOCK_ADD[@]}"; do
    dockutil --add "$app" &>/dev/null
  done
  # Handle removals
  for app in "${DOCK_REMOVE[@]}"; do
    dockutil --remove "$app" &>/dev/null
  done
fi

# Change shell to fish shell
chsh -s $(which fish)

# Git Login
echo
echo "${GREEN}SET UP GIT"
echo

echo "${RED}Please enter your git username:${NC}"
read name
echo "${RED}Please enter your git email:${NC}"
read email

git config --global user.name "$name"
git config --global user.email "$email"
git config --global color.ui true

echo
echo "${GREEN}GITTY UP!"

clear
echo "${GREEN}______ _____ _   _  _____ "
echo "${GREEN}|  _  \  _  | \ | ||  ___|"
echo "${GREEN}| | | | | | |  \| || |__  "
echo "${GREEN}| | | | | | | .   ||  __| "
echo "${GREEN}| |/ /\ \_/ / |\  || |___ "
echo "${GREEN}|___/  \___/\_| \_/\____/ "
