eg-help() {
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    RED='\033[0;31m'
    ORANGE='\033[0;33m'
    RESET='\033[0m'

    echo -e "\nWelcome to the Easy Git Helper!\n"

    echo -e "Here are all the easy-git functions created to help you set up  and use your git workspace easier.\n"

    echo -e "The ${RED}red${RESET} text indicates the required arguments for each function."
    echo -e "The ${ORANGE}orange${RESET} text indicates the optional arguments for each function.\n"

    echo -e "Available functions:\n"
    for func in eg-setup eg-worktree eg-rebase eg-emojis; do
        echo -e "  ${BLUE}$func:${RESET}"
        case "$func" in
        "eg-setup")
            echo -e "    Clone a repository, add the emojis and create a worktree.\n"
            echo -e "    Usage: ${GREEN}eg-setup${RESET} ${RED}<repo_url>${RESET} ${ORANGE}<branch_name>${RESET}"
            echo -e "      ${RED}repo_url:${RESET} The HTTPS or SSH link of the repository to clone."
            echo -e "      ${ORANGE}branch_name:${RESET} [OPTIONAL] The name of the branch to create a worktree for."
            ;;
        "eg-worktree")
            echo -e "    Create a new worktree for a branch.\n"
            echo -e "    Usage: ${GREEN}eg-worktree${RESET} ${RED}<branch_name>${RESET}"
            echo -e "      ${RED}branch_name:${RESET} The name of the branch to create a worktree for."
            ;;
        "eg-rebase")
            echo -e "    Rebase the current branch on another branch.\n"
            echo -e "    Usage: ${GREEN}eg-rebase${RESET} ${RED}<branch_name>${RESET}"
            echo -e "      ${RED}branch_name:${RESET} The name of the branch to rebase on."
            ;;
        "eg-emojis")
            echo -e "    Add emojis to .git/hooks/ directory.\n"
            echo -e "    Usage: ${GREEN}eg-emojis${RESET}"
            ;;
        *)
            echo -e "  ${RED}No help text available.${RESET}"
            ;;
        esac
        echo ""
    done
}

# Clone a repository, add the emojis to the hooks directory and [optionally] create a worktree for a branch
eg-setup() {
    if [ -z "$1" ]; then
        echo -e "eg: Please provide a repository URL."
        echo -e "eg: ❌ Operation aborted. ❌"
        return 1
    fi
    repo_name=$(basename -s .git "$1")
    git clone "$1" main && cd main
    cp ~/.gitemojis/* .git/hooks/
    if [ -z "$2" ]; then
        echo "eg: No branch name provided for worktree. No worktree created."
        return 1
    else
        git worktree add ../$2 $2
        cd ../$2
        echo "eg: 🎉 Successfully cloned and set up: $repo_name 🎉"
        return 0
    fi
}

# Create a worktree for a branch
eg-worktree() {
    if [ -z "$1" ]; then
        echo -e "eg: Please provide a branch name."
        echo -e "eg: ❌ Operation aborted. ❌"
        return 1
    fi

    if [ ! -d ".git/" ]; then
        echo -e "eg: .git directory not found. Consider moving to the directory of your clone (main)."
        echo -e "eg: ❌ Operation aborted. ❌"
        return 1
    fi
    git worktree add ../$1 $1
    if [ ! -d "../$1" ]; then
        echo -e "eg: The worktree has not been created. Consider verifying if the branch exists or has been misspelt."
        echo -e "eg: ❌ Operation aborted. ❌"
        return 1
    else
        cd ../$1
        echo "🎉 Successfully created worktree: $1 🎉"
        return 0
    fi
}

# Rebase the current branch on another branch
eg-rebase() {
    if [ -z "$1" ]; then
        echo -e "eg: Please provide a branch name."
        echo -e "eg: ❌ Operation aborted. ❌"
        return 1
    fi
    if [ ! -d "../$1" ]; then
        echo -e "eg: Folder does not exist. Consider renaming your folder according to the name of your branch."
        echo -e "eg: ❌ Operation aborted. ❌"
        return 1
    fi

    cd ../$1
    git pull
    cd -

    read -r confirm"?eg: Are you sure you want to continue? [Y/n] " # for zsh
    #read -p "eg: Are you sure you want to continue? [Y/n] " -n 1 -r confirm # for bash
    if [[ $confirm =~ ^[Yy]$ ]]; then
        git rebase $1
        git push -f
        echo "eg: 🎉 Successfully rebased this branch on $1 🎉"
        return 0
    else
        echo "eg: ❌ Operation aborted. ❌"
        return 1
    fi
}

# Add emojis to .git/hooks/ directory
eg-emojis() {
    if [ ! -d ".git/hooks/" ]; then
        echo -e "eg:  .git directory not found."
        echo -e "eg: ❌ Operation aborted. ❌"
        return 1
    fi
    cp ~/.gitemojis/* .git/hooks/
    echo "eg: 🎉 Successfully added emojis to: .git/hooks/ 🎉"
    return 0
}
