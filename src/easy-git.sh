#!/bin/sh

# === Default Helper ===
git-help() {
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    RED='\033[0;31m'
    ORANGE='\033[0;33m'
    RESET='\033[0m'

    echo -e "\nWelcome to the Easy Git Helper!\n"

    echo -e "Here are all the easy-git functions created to help you set up and use your git workspace easier.\n"

    echo -e "Available functions:\n"
    for func in git-setup git-addworktree git-rmworktree git-addbranch git-rebase git-emojis; do
        echo -e "  ${BLUE}$func:${RESET}"
        case "$func" in
        "git-setup")
            echo -e "    Clone a repository, add the emojis and create worktrees.\n"
            echo -e "    Usage: ${GREEN}git-setup${RESET} ${RED}<repo_url>${RESET} ${ORANGE}<branch_name>${RESET}"
            echo -e "      ${RED}repo_url:${RESET} The HTTPS or SSH link of the repository to clone."
            echo -e "      ${ORANGE}branch_name:${RESET} [OPTIONAL] The name of the branch to create a worktree for. You can add as many as you want."
            ;;
        "git-addworktree")
            echo -e "    Create a new worktree for a branch.\n"
            echo -e "    Usage: ${GREEN}git-addworktree${RESET} ${RED}<branch_name>${RESET}"
            echo -e "      ${RED}branch_name:${RESET} The name of the branch to create a worktree for."
            ;;
        "git-rmworktree")
            echo -e "    Remove a worktree for a branch.\n"
            echo -e "    Usage: ${GREEN}git-rmworktree${RESET} ${RED}<branch_name>${RESET}"
            echo -e "      ${RED}branch_name:${RESET} The name of the branch to remove a worktree for."
            ;;
        "git-addbranch")
            echo -e "    Create a branch and a worktree for it.\n"
            echo -e "    Usage: ${GREEN}git-addbranch${RESET} ${RED}<branch_name>${RESET}"
            echo -e "      ${RED}branch_name:${RESET} The name of the branch to create a worktree for."
            ;;
        "git-rebase")
            echo -e "    Rebase the current branch on another branch.\n"
            echo -e "    Usage: ${GREEN}git-rebase${RESET} ${RED}<branch_name>${RESET}"
            echo -e "      ${RED}branch_name:${RESET} The name of the branch to rebase on."
            ;;
        "git-emojis")
            echo -e "    Add emojis to .git/hooks/ directory.\n"
            echo -e "    Usage: ${GREEN}git-emojis${RESET}"
            ;;
        *)
            echo -e "  ${RED}No help text available.${RESET}"
            ;;
        esac
        echo ""
    done
}

# === Clone a repository, add the emojis to the hooks directory and [optionally] create a worktree for a branch  ===

git-setup() {
    if [ -z "$1" ]; then
        echo "git: Please provide a repository URL."
        echo "git: ❌ Operation aborted. ❌"
        return 1
    fi
    repo_name=$(basename -s .git "$1")

    echo "git: 🛠️ Creating project's folder 🛠️"
    mkdir -p "$repo_name" && cd "$repo_name"

    echo "git: 🛠️ Cloning the project 🛠️"
    git clone "$1" main && cd main

    echo "git: 🛠️ Adding the emojis hooks 🛠️"
    cp ~/Easy-Git/src/assets/gitemojis/* .git/hooks/

    shift

    if [ $# -eq 0 ]; then
        echo "git: No branch names provided for worktree. No worktree created."
        echo "git: 🎉 Successfully cloned and set up: $repo_name! 🎉"
        return 0
    else
        for branch_name in "$@"; do
            echo "git: 🛠️ Creating the worktree for branch: $branch_name 🛠️"
            git worktree add ../$branch_name $branch_name
        done
            echo "git: 🎉 Successfully cloned and set up: $repo_name! 🎉"
        return 0
    fi
}

# === Create a worktree for a branch ===

git-addworktree() {
    if [ -z "$1" ]; then
        echo "git: Please provide a branch name."
        echo "git: ❌ Operation aborted. ❌"
        return 1
    fi

    if [ ! -d ".git/" ]; then
        echo "git: .git directory not found. Consider moving to the directory of your clone (main)."
        echo "git: ❌ Operation aborted. ❌"
        return 1
    fi
    echo "git: 🛠️ Pulling on main 🛠️"
    git pull

    echo "git: 🛠️ Creating the worktree 🛠️"
    git worktree add ../$1 $1
    if [ ! -d "../$1" ]; then
        echo "git: The worktree has not been created. Consider verifying if the branch exists or has been misspelt."
        echo "git: ❌ Operation aborted. ❌"
        return 1
    else
        cd ../$1
        echo "🎉 Successfully created worktree: $1 🎉"
        return 0
    fi
}

# === Remove a worktree for a branch ===

git-rmworktree() {
    if [ -z "$1" ]; then
        echo "git: Please provide a branch name."
        echo "git: ❌ Operation aborted. ❌"
        return 1
    fi

    if [ ! -d ".git/" ]; then
        echo "git: .git directory not found. Consider moving to the directory of your clone (main)."
        echo "git: ❌ Operation aborted. ❌"
        return 1
    fi

    echo "git: 🛠️ Removing the worktree 🛠️"
    git worktree remove ../$1
    if [ -d "../$1" ]; then
        echo "git: The worktree has not been removed. Consider verifying if the branch exists or has been misspelt."
        echo "git: ❌ Operation aborted. ❌"
        return 1
    else
        echo "git: 🎉 Successfully removed worktree: $1 🎉"
        return 0
    fi
}

# === Create a branch and a worktree for it ===

git-addbranch() {
    if [ -z "$1" ]; then
        echo "git: Please provide a branch name."
        echo "git: ❌ Operation aborted. ❌"
        return 1
    fi
    if [ ! -d ".git/" ]; then
        echo "git: .git directory not found. Consider moving to the directory of your clone (main)."
        echo "git: ❌ Operation aborted. ❌"
        return 1
    fi

    branch_name="$1"

    echo "git: Please choose an option:"
    echo "git: 1. Feature"
    echo "git: 2. Documentation"
    echo "git: 3. Tests"
    echo "git: 4. Bugfix"
    echo "git: 5. General improvements"

    read -r choice"?git: Enter your choice: " # for zsh
    #read -p "git: Enter your choice: " choice -n 1 -r confirm # for bash

    case $choice in
        1)
            branch_name="feature-$1"
            ;;
        2)
            branch_name="docs-$1"
            ;;
        3)
            branch_name="test-$1"
            ;;
        4)
            branch_name="fix-$1"
            ;;
        5)
            branch_name="general-$1"
            ;;
        *)
            echo "git: Invalid choice. Please try again." 
            echo "git: ❌ Operation aborted. ❌"
            return 1
            ;;
    esac

    echo "git: 🛠️ Creating the branch 🛠️"
    git checkout -b "$branch_name" dev
    git push -u origin "$branch_name"
    git checkout main

    echo "git: 🛠️ Creatign the worktree 🛠️"
    git worktree add "../$branch_name" "$branch_name"
    cd "../$branch_name"

    echo "git: 🎉 Successfully created and set up branch: $branch_name 🎉"
    return 0

}

# === Rebase the current branch on another branch ===

git-rebase() {
    if [ -z "$1" ]; then
        echo -e "git: Please provide a branch name."
        echo -e "git: ❌ Operation aborted. ❌"
        return 1
    fi
    if [ ! -d "../$1" ]; then
        echo -e "git: Folder does not exist. Consider renaming your folder according to the name of your branch."
        echo -e "git: ❌ Operation aborted. ❌"
        return 1
    fi

    read -r stash"?git: Is there changes to stash? [Y/n] " # for zsh
    #read -p "git: Is there changes to stash? [Y/n] " -n 1 -r stash # for bash
    if [[ $stash =~ ^[Yy]$ ]]; then
        echo "git: 🛠️ Stash current changes 🛠️"
        git stash
    else
        echo "git: 🛠️ No stash required 🛠️"
    fi

    echo "git: 🛠️ Pulling latest commits on $1 🛠️"
    cd ../$1
    git pull
    cd -

    echo "git: 🛠️ Proceed to rebase 🛠️"
    read -r confirm"?git: Are you sure you want to continue? [Y/n] " # for zsh
    #read -p "git: Are you sure you want to continue? [Y/n] " -n 1 -r confirm # for bash
    if [[ $confirm =~ ^[Yy]$ ]]; then
        git rebase $1
        git push -f
        echo "git: 🎉 Successfully rebased this branch on $1 🎉"
        if [[ $stash =~ ^[Yy]$ ]]; then
            echo "git: 🛠️ Apply stash saved 🛠️"
            git stash apply
            echo "git: 🛠️ Drop stash saved 🛠️"
            git stash drop
            echo "git: 🎉 Successfully applied stash saved 🎉"
        fi
        return 0
    else
        echo "git: ❌ Operation aborted. ❌"
        return 1
    fi
}

# === Add emojis to .git/hooks/ directory ===

git-emojis() {
    if [ ! -d ".git/hooks/" ]; then
        echo -e "git:  .git directory not found."
        echo -e "git: ❌ Operation aborted. ❌"
        return 1
    fi
    echo "git: 🛠️ Adding emojis to .git/hooks/ 🛠️"
    cp ~/Easy-Git/src/assets/gitemojis/* .git/hooks/
    
    echo "git: 🎉 Successfully added emojis to: .git/hooks/ 🎉"
    return 0
}
