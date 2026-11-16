## Installation


### Clone nvim configs

```sh
git clone https://github.com/removed-user/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```


### External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, `gcc`

Extras:
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
- [fd-find](https://github.com/sharkdp/fd#installation)
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md#installation)
- A Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - If you have it, set `vim.g.have_nerd_font` in `init.lua` to true

#### Configs

Neovim's configurations are located under 

- `$XDG_CONFIG_HOME/nvim`
- `~/.config/nvim`

#### Maybe

- You may want to remove `lazy-lock.json` from your fork's `.gitignore` file
- It's ignored in kickstart repo to make maintenance easier, but - is
[recommended to track it in version control](https://lazy.folke.io/usage/lockfile).

### Post Install

Start Neovim

```sh
nvim
```

Use `:Lazy` to view the current plugin status. 

#### Read The Friendly Documentation

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.


### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

* [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations.
For example:
You can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`.

You can apply this approach to any Neovim distribution youd like to try out.

 -   As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts.
A fork of kickstart that does this while maintaining the same functionality is available here:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * *NOTE: This is the fork that splits the configuration into smaller parts.*
    The original repo with the single `init.lua` file is available here:
    * [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
  * Discussions on this topic can be found here:
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest

['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.

Issues?, make sure you have at least the latest
stable version. 

[package_manager](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package).

check version
 `nvim --version` 
make sure it is not below the latest

['stable'](https://github.com/neovim/neovim/releases/tag/stable) version. 

If your chosen install method only gives you an outdated version of neovim, find
alternative [installation methods below](#alternative-neovim-installation-methods).

### Alternative neovim installation methods

For some systems it is expected that the
[package manager installation_method](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package)

Recommended by neovim: 
Is significantly behind... If so... pick one of the following methods that are known to deliver fresh neovim versions very quickly.

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install Kickstart](#install-kickstart) step.

#### Per Distro
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep fd-find tree-sitter-cli unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep fd-find tree-sitter-cli unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd tree-sitter-cli unzip neovim
```
</details>

