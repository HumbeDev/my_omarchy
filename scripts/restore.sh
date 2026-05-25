#!/bin/bash

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "--- Iniciando restauración de sistema ---"

# 1. Instalar yay si no existe
if ! command -v yay &> /dev/null; then
    echo "Instalando yay..."
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si
    cd "$REPO_DIR"
fi

# 2. Instalar paquetes
echo "Instalando paquetes desde las listas..."
# Paquetes oficiales
sudo pacman -S --needed - < "$REPO_DIR/packages/pacman_list.txt"
# Paquetes AUR
yay -S --needed - < "$REPO_DIR/packages/aur_list.txt"
# Flatpaks
if [ -f "$REPO_DIR/packages/flatpak_list.txt" ]; then
    echo "Instalando Flatpaks..."
    xargs flatpak install -y < "$REPO_DIR/packages/flatpak_list.txt"
fi

# 3. Restaurar configuraciones
echo "Restaurando archivos de configuración..."
mkdir -p ~/.config/omarchy
rsync -av "$REPO_DIR/config/omarchy/" ~/.config/omarchy/

# Restaurar carpetas extra si existen
for dir in hypr waybar alacritty ghostty kitty mako; do
    if [ -d "$REPO_DIR/config/extra/$dir" ]; then
        echo "Restaurando configuración de $dir..."
        mkdir -p "$HOME/.config/$dir"
        rsync -av "$REPO_DIR/config/extra/$dir/" "$HOME/.config/$dir/"
    fi
done

cp "$REPO_DIR/config/zshrc" ~/.zshrc
cp "$REPO_DIR/config/bashrc" ~/.bashrc
cp "$REPO_DIR/config/starship.toml" ~/.config/starship.toml

# 4. Restaurar scripts personales
echo "Restaurando scripts en ~/.local/bin..."
mkdir -p ~/.local/bin
cp "$REPO_DIR/bin/"* ~/.local/bin/
chmod +x ~/.local/bin/*

echo "--- Restauración completada ---"
echo "Nota: Es posible que necesites reiniciar tu sesión para ver todos los cambios."
