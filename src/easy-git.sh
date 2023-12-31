# >>> easygit custom functions >>>
eg-help() {
    # Define ANSI color codes
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    RED='\033[0;31m'
    ORANGE='\033[0;33m'
    RESET='\033[0m'

    echo -e "\nWelcome to the Easy Git Helper!\n"

    echo -e "Here are all the easy-git functions created to help you set up  and use your git workspace easier.\n"

    echo -e "The ${RED}red${RESET} text indicates the required arguments for each function."
    echo -e "The ${ORANGE}orange${RESET} text indicates the optional arguments for each function.\n"
    echo -e "Available functions:"

    for func in eg-setup eg-worktree eg-rebase eg-emojis; do
        echo -e "${BLUE}$func:${RESET}"
        case "$func" in
            "eg-setup")
                echo -e "  Clone a repository, add the emojis and create a worktree.\n"
                echo -e "  Usage: ${GREEN}eg-setup${RESET} ${RED}<repo_url>${RESET} ${ORANGE}<branch_name>${RESET}"
                echo -e "    ${RED}repo_url:${RESET} The HTTPS or SSH link of the repository to clone."
                echo -e "    ${ORANGE}branch_name:${RESET} [OPTIONAL] The name of the branch to create a worktree for."
                ;;
            "eg-worktree")
                echo -e "  Create a new worktree for a branch.\n"
                echo -e "  Usage: ${GREEN}eg-worktree${RESET} ${RED}<branch_name>${RESET}"
                echo -e "    ${RED}branch_name:${RESET} The name of the branch to create a worktree for."
                ;;
            "eg-rebase")
                echo -e "  Rebase the current branch on another branch.\n"
                echo -e "  Usage: ${GREEN}eg-rebase${RESET} ${RED}<branch_name>${RESET}"
                echo -e "    ${RED}branch_name:${RESET} The name of the branch to rebase on."
                ;;
            "eg-emojis")
                echo -e "  Add emojis to .git/hooks/ directory.\n"
                echo -e "  Usage: ${GREEN}eg-emojis${RESET}"
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
            echo "${RED}Please provide a repository URL.${RESET}"
            return 1
    fi
    repo_name=$(basename -s .git "$1")
    git clone "$1" main && cd main
    cp ~/.gitemojis/* .git/hooks/
    if [ -z "$2" ]; then
            echo "${RED}No branch name provided for worktree. No worktree created.${RESET}"
            return 1
    else
            git worktree add ../$2 $2
            cd ../$2
    fi
    echo "🎉 Successfully cloned and set up: $repo_name 🎉"
    return 0
}

# Create a worktree for a branch
eg-worktree() {
    if [ -z "$1" ]; then
            echo "${RED}Please provide a branch name.${RESET}"
        return 1
    fi

    git worktree add ../$1 $1
    cd ../$1
    echo "🎉 Successfully created worktree: $1 🎉"
    return 0
}

# Rebase the current branch on another branch
eg-rebase() {
    if [ -z "$1" ]; then
        echo "Please provide a branch name."
        return 1
    fi
    cd ../$1
    git pull
    cd -
    git rebase $1
    git push -f
    echo "🎉 Successfully rebased this branch on $1 🎉"
    return 0
}
# Add emojis to .git/hooks/ directory
eg-emojis() {
    cp ~/.gitemojis/* .git/hooks/
    echo "🎉 Successfully added emojis to: .git/hooks/ 🎉"
    return 0
}
# <<< easygit custom functions <<<