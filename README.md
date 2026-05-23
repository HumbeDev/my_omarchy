# My Omarchy Dotfiles

Repositorio personal para respaldar la configuración de Omarchy, scripts propios y listas de programas instalados en CachyOS.

## Estructura
- `bin/`: Scripts personales de `~/.local/bin`.
- `config/`: Archivos de configuración (Omarchy, Shells, Starship).
- `packages/`: Listas de paquetes instalados (Pacman y AUR).
- `scripts/`: Scripts de automatización de respaldo y restauración.

## Cómo usar

### Respaldar (Actualizar)
Para capturar el estado actual de tu sistema:
```bash
./scripts/backup.sh
```
Luego sube los cambios a GitHub:
```bash
git add .
git commit -m "Update system state"
git push origin main
```

### Restaurar (Nueva PC)
1. Instalar CachyOS.
2. Clonar este repositorio.
3. Ejecutar el script de restauración:
```bash
./scripts/restore.sh
```

## Proyectos Personales
Para tus proyectos en `~/Projects`, se recomienda inicializarlos como repositorios independientes en GitHub.
