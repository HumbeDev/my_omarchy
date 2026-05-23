#!/bin/bash

# List of themes to rotate
themes=(
    "Tokyo Night"
    "Ethereal"
    "Aetheria"
    "Kanagawa"
    "Retro 82"
    "Dracula"
)

# Pick a random theme
selected_theme="${themes[$RANDOM % ${#themes[@]}]}"
echo "Selected theme: $selected_theme"

# Apply the theme using omarchy
omarchy theme set "$selected_theme"
