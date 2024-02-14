# Easy-Git

> Easy Git is a simple tool to help you set up and use your git workspaces.

![Easy Git](src/assets/demo.png)

## Getting Started

### Introduction

Easy Git is a simple tool to help you set up and use your git workspaces. It is designed to be used with a terminal and is written in zsh. It is a simple script that allows you to set up a git workspace, add or remove worktrees, rebase after a PR merge, and manually add emojis to a local repository.

### Prerequisites

- [Git](https://git-scm.com/downloads)
- A terminal on zsh preferably, but check the warning below if you use bash

### Install

Get into your terminal in your home directory or where you want to install the project (somewhere stable).

```sh
cd ~
```

To install Easy Git, run the following command (at the same level as your .bashrc or .zshrc file):

```sh
git clone https://github.com/MorganKryze/Easy-Git.git
```

Or click on the green "Code" button and download the zip file.

Then, go to the project directory:

```sh
cd Easy-Git
```

You can add the commands to your shell configuration file (e.g. `~/.zshrc`). To do so, use the following command:

```sh
sh add-commands.sh
```

You will need to restart your terminal to use the commands below.

### Usage

> [!WARNING]
> The script are written for a zsh, if you want to use it with bash, you will have to change the script slightly:
> Comment the line 111 and uncomment the line 112. The issue comes from the fact that bash and zsh have different syntax for the read command.

Try to run the following command to check that the commands are installed and accessible:

```sh
git-help
```

If you encounter an error, refer to the [Troubleshooting](#troubleshooting) section.

> [!TIP]
> The project uses [Git emojis](https://github.com/Buzut/git-emojis-hook) from [Buzut](https://github.com/Buzut). That means that you can use emojis in your commit messages. The script will automatically add the emoji to your commit message if you use the right syntax. For example, if you want to add a "feature" emoji to your commit message, you can write `:feat: Add a breaking change feature` and the script will automatically replace it with the emoji.

You may now use these commands:

- `git-help`: Display the help message.
- `git-setup`: Setup a git workspace (clone, add emojis).
- `git-addbranch`: Add brand & worktree to a local repository.
- `git-addworktree`: Add a worktree to the current repository.
- `git-rmworktree`: Remove a worktree from the current repository.
- `git-rebase`: Rebase after PR merge (fix the 1 commit ahead and behind) and allow to stash changes.
- `git-addemojis`: Manually add emojis to a local repository.

> [!TIP]
> Always use the `git-help` command to get the help message and the list of available commands and their needed arguments.

### Troubleshooting

If you encounter this error message (or for any command):

```plaintext
zsh: command not found: git-help
```

You may not have add the path to the `easy-git.sh` file to your shell configuration file (e.g. `~/.zshrc`) or moved the project directory.

Then redo the following command and restart your terminal (or add manually the path to your .zshrc located in `~/.zshrc`):

```sh
sh add-commands.sh
```

### Project structure

Here are the most important files and directories of the project (you may ignore the other files and directories):

```plaintext
Easy-Git
├── src
│   ├── assets
│   │   └── img
│   │       └── screenshot.png
│   └── easy-git.sh
├── .gitignore
├── add-commands.sh
├── SECURITY
├── CODE_OF_CONDUCT
├── CONTRIBUTING
├── LICENCE
└── README.md
```

#### Small descriptives

##### `src/`

This directory contains the source code of the project.

##### `src/assets/`

This directory contains the assets of the project.

##### `easy-git.sh`

The main file of the project. It contains the commands of the project.

##### `add-commands.sh`

A file to add the commands to your shell configuration file (e.g. `~/.zshrc`).

## Supported platforms

(Tested on MacOS)

- zsh
- bash

## Future improvements

- Compatibility with other shells
- Add more commands to manage workspaces
- Use of gitflow

## Contributing

If you want to contribute to the project, you can follow the steps described in the [CONTRIBUTING](CONTRIBUTING) file.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details.
