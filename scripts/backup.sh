#!/bin/bash

# Directorio base del repositorio (donde está este script)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "--- Iniciando respaldo de configuración y programas ---"

# 1. Exportar listas de paquetes
echo "[1/4] Exportando listas de paquetes..."
pacman -Qqe > "$REPO_DIR/packages/pacman_list.txt"
pacman -Qqm > "$REPO_DIR/packages/aur_list.txt"
if command -v flatpak &> /dev/null; then
    flatpak list --columns=application > "$REPO_DIR/packages/flatpak_list.txt"
fi

# 2. Respaldar configuración de Omarchy
echo "[2/4] Respaldando configuración de Omarchy..."
# Usamos rsync para mantener la estructura pero evitando basura innecesaria
rsync -av --delete --exclude '*/cache/*' ~/.config/omarchy/ "$REPO_DIR/config/omarchy/"

# 3. Respaldar scripts personales en ~/.local/bin
echo "[3/4] Respaldando scripts personales en ~/.local/bin..."
mkdir -p "$REPO_DIR/bin"
# Copiamos solo archivos menores a 1MB (scripts) y evitamos binarios pesados
find ~/.local/bin -maxdepth 1 -type f -size -1M -exec cp {} "$REPO_DIR/bin/" \;

# 4. Otros dotfiles importantes
echo "[4/4] Respaldando otros dotfiles..."
cp ~/.zshrc "$REPO_DIR/config/zshrc"
cp ~/.bashrc "$REPO_DIR/config/bashrc"
cp ~/.config/starship.toml "$REPO_DIR/config/starship.toml"

# Respaldar carpetas críticas de .config (opcional, por si acaso)
mkdir -p "$REPO_DIR/config/extra"
for dir in hypr waybar alacritty ghostty kitty mako; do
    if [ -d "$HOME/.config/$dir" ]; then
        rsync -av --delete "$HOME/.config/$dir/" "$REPO_DIR/config/extra/$dir/"
    fi
done

echo "--- Respaldo completado en $REPO_DIR ---"
echo "Para subir a GitHub:"
echo "  cd $REPO_DIR"
echo "  git add ."
echo "  git commit -m 'Actualización de respaldo: $(date +%Y-%m-%d)'"
echo "  git push origin main"
