#!/bin/bash

# === Define the path to the script ===

echo "easy-git: 🛠️ Getting the full path of easy-git.sh 🛠️"
full_path=$(realpath src/easy-git.sh)
line_to_add="\n# Easy-Git is a simple tool to manage git workspace\nsource $full_path"

# === Add the reference to the script in .zshrc ===

echo "easy-git: 🛠️ Trying to add the reference to the file in the .zshrc 🛠️"
if [ -f ~/.zshrc ]; then
    if ! grep -qF "source $full_path" ~/.zshrc; then
        echo "$line_to_add" >>~/.zshrc
        echo "easy-git: 🎉 Line successfully added! You may restart your terminal to use the functions. 🎉"
    else
        echo "easy-git: 🛠️ Line already exists in .zshrc. No action taken. 🛠️"
    fi
else
    echo "easy-git: .zshrc file not found. Please create one in your home directory."
    echo "easy-git: ❌ Operation aborted. ❌"
fi
