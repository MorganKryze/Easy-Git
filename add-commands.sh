#!/bin/bash

# === Define the path to the script ===

echo "easy-git: 🛠️ Getting the full path of easy-git.sh 🛠️"
full_path_shell=$(realpath src/easy-git.sh)
full_path_project=$(realpath .)

# === Add the reference to the script and set the path as an environment variable ===

line_to_add="\n# Easy-Git is a simple tool to manage git workspace\nexport EASY_GIT_PATH=\"$full_path_project\"\nsource \"$full_path_shell\""

# === Add the reference to the script in .zshrc ===

echo "easy-git: 🛠️ Trying to add the reference to the file in the .zshrc 🛠️"
if [ -f ~/.zshrc ]; then
    if ! grep -qF "source \"$full_path_shell\"" ~/.zshrc; then
        echo -e "$line_to_add" >>~/.zshrc
        echo "easy-git: 🎉 Lines successfully added! You may restart your terminal to use the functions. 🎉"
    else
        echo "easy-git: 🛠️ Lines already exists in .zshrc. No action taken. 🛠️"
    fi
else
    echo "easy-git: .zshrc file not found. Please create one in your home directory."
    echo "easy-git: ❌ Operation aborted. ❌"
fi
