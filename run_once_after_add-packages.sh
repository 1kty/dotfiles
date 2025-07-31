#!/bin/sh
# Bootstrap script installating packages, extensions, themes and languages and setting up services

# 1. System update
echo Running system update...
sudo pacman -Syu --noconfirm

# 2. Package installation
PKGS=(
    git curl wget gnome firefox zsh git-delta ripgrep eza fd bat fzf btop htop yazi fastfetch jq glow duf ghostty noto-fonts ttf-dejavu gnu-free-fonts pyenv nvm rustup go base-devel clang gcc man-db man-pages d-spy dconf-editor file-roller ghex gnome-sound-recorder gnome-tweaks dpkg cdrtools p7zip unrar unzip zip gnome-shell-extension-appindicator ghostty obs-studio bitwarden ffmpeg vim neovim nano sysprof tk proton-vpn-gtk-app cava ttf-firacode-nerd ttf-fira-code adobe-source-code-pro-fonts ttf-sourcecodepro-nerd otf-cascadia-code ttf-cascadia-code-nerd ttf-jetbrains-mono ttf-jetbrains-mono-nerd github-cli ttf-hack ttf-hack-nerd virt-manager collision gimp resources solanum blanket bluez bluez-utils decoder reflector eyedropper switcheroo snapper snap-pac noto-fonts-cjk noto-fonts-extra qemu-base
)

echo Installing packages...
sudo pacman -S --noconfirm "${PKGS[@]}"

# 3. Yay installation
echo Installing Yay...
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# 4. AUR packages installation
AUR_PKGS=(
    extension-manager gnome-shell-extension-pop-shell-git spotify vesktop-bin visual-studio-code-bin pyenv-virtualenv notion-app-electron gnome-extensions-cli ttf-apple-emoji apple-fonts localsend snapper-rollback btrfs-assistant
)

echo Installing AUR packages...
yay -S --noconfirm "${AUR_PKGS[@]}"w

# 5. GNOME extensions installation (using gnome-extensions-cli)
echo Installing GNOME extensions...
gext install Bluetooth-Battery-Meter@maniacx.github.com blur-my-shell@aunetx clipboard-history@alexsaveau.dev dash2dock-lite@icedman.github.com just-perfection-desktop@just-perfection mediacontrols@cliffniff.github.com top-bar-organizer@julian.gse.jsts.xyz quick-settings-avatar@d-go user-theme@gnome-shell-extensions.gcampax.github.com Vitals@CoreCoding.com

# 6. Themes and icons
mkdir -p ~/Themes

echo Installing WhiteSur theme...
mkdir -p ~/Themes/WhiteSur
cd ~/Themes/WhiteSur
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme
WhiteSur-gtk-theme/install.sh -o normal -l
git clone https://github.com/vinceliuice/WhiteSur-icon-theme
WhiteSur-icon-theme/install.sh
git clone https://github.com/vinceliuice/WhiteSur-cursors
WhiteSur-cursors/install.sh
cd ~

echo Installing MacTahoe theme...
mkdir -p ~/Themes/MacTahoe
cd ~/Themes/MacTahoe
git clone https://github.com/vinceliuice/MacTahoe-gtk-theme
MacTahoe-gtk-theme/install.sh -o normal
git clone https://github.com/vinceliuice/MacTahoe-icon-theme
MacTahoe-icon-theme/install.sh
cd ~

# 7. Languages and runtimes
# Rust
echo Setting up Rust...
rustup default stable
rustup toolchain install stable

# Python
echo Setting up Python...
eval "$(pyenv init -)"
pyenv install 3:latest
pyenv global $(pyenv versions --bare)
pip install --upgrade pip
pip install flake8 black setuptools wheel

# Node.js
echo Setting up Node.js...
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/share/nvm/init-nvm.sh" ] && source "/usr/share/nvm/init-nvm.sh"
nvm install --lts
nvm set-colors cgYmW
npm install -g pnpm

# 8. Change user shell
echo Changing user shell...
chsh -s /usr/bin/zsh

# 9. Snapper
echo Setting up snapper...
sudo snapper -c root create-config /

# 10. Enabling services...
SERVICES=(
    snapper-timeline.timer snapper-cleanup.timer bluetooth.service
)

echo Enabling services...
for service in "${SERVICES[@]}"; do
  sudo systemctl enable --now "$service"
done

echo Installation complete!