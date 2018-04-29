# Introduction
Relatively lightweight Zsh and Vim configuration i use on servers, without any dependencies.

* Uses some files of oh-my-zsh
* Custom prompt inspired by [Pure Zsh prompt](https://github.com/sindresorhus/pure)
* [Solarized theme for Vim](https://github.com/altercation/vim-colors-solarized)

Features:
* Username and host only displayed if connected to a server by SSH
* Username shown in red if it's root (UID 0)
* Prompt "❱" turns red if last command exited with an error
* Git status on the right side if current directory is within a git repository
* Staged changes in repository shown in green, unstaged in red

## Screenshot
![Example screenshot](https://raw.githubusercontent.com/ursweiss/screenshots/master/dotfiles-server/dotfiles-server-example.png)

# Install the dotfiles on a server
## Without git installed (Recommended)
This is the quick and easy way to install the current dotfiles on the machine.
I do recommend this option as long you don't want to change the files and push them back to the repository.

Copy & paste these lines to you terminal:
```sh
### Warning: This overwrites all the files within the home directory with the ones in the repository without any further warning!
cd ~
curl -L https://api.github.com/repos/ursweiss/dotfiles-server/tarball/master | tar xz --strip=1
rm README.md
```

## With git installed
If you want to use git to install/update the dotfiles.

If not done already, you should set the name and eMail address git uses first:
```sh
git config --global user.name "your name"
git config --global user.email "email@domain.com"
```
It's very likely that some of the files in the repository already exist on the local machine. These will cause conflicts when a normal `git clone` command is used.

To prevent this, we initialize a new git repository, fetch all the content from the repository and then reset to the most recent commit.

```sh
cd ~
git init
git remote add origin https://github.com/ursweiss/dotfiles-mac
git fetch --all
git reset --hard origin/master
```

**Optional:** Set an git config option to not show any version control state for the dotfile repository. This will speed up the prompt within the home directory significantly.
```sh
git config --add zsh-git.hide-status 1
```
