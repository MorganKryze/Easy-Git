# Easy-Git

> Easy Git is a simple tool to help you set up and use your git workspaces.

![Easy Git](src/assets/demo.png)

## Getting Started

### Prerequisites

- [Git](https://git-scm.com/downloads)
- [Git emojis](https://github.com/Buzut/git-emojis-hook) installed at your root folder
- A terminal on zsh preferably, but check the warning below if you use bash

### Install

To install Easy Git, run the following command at the same level as your .bashrc or .zshrc file:

```sh
git clone https://github.com/MorganKryze/Easy-Git.git
```

### How to use

To use Easy Git, simply add this line to your .bashrc or .zshrc file:

```sh
source ~/Easy-Git/src/easy-git.sh
```

Then, back on your terminal, run the following command:

```sh
source ~/.bashrc # or ~/.zshrc
```

You're all set up! Now, start using Easy Git by running the following command:

```sh
eg-help
```

> [!WARNING]
> The script are written for a zsh, if you want to use it with bash, you will have to change the script slightly:
> Comment the line 111 and uncomment the line 112. The issue comes from the fact that bash and zsh have different syntax for the read command.

### Features

- [x] Setup a git workspace (clone, add emojis)
- [x] Add workspace
- [x] Rebase after PR merge (fix the 1 commit ahead and behind)
- [x] Manually add emojis to a local repository

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
