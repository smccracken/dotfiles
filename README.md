# My dotfiles

This directory contains the dotfiles for my system, managed with stow

## Requirements

Ensure you have the following installed on your system

### Homebrew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Xcode command line tools (with git)

```
xcode-select --install
```

#### Verify git install

```
git -v
```

### Stow

```
brew install stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com:smccracken/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```
