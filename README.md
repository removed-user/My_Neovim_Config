## Installation


### Clone nvim configs

```sh
git clone https://github.com/removed-user/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

### External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, `gcc`

Extras:
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- [fd-find](https://github.com/sharkdp/fd#installation)
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md#installation)
- [Clipboard_tool]
- For X
   - [xclip](https://github.com/astrand/xclip.git)
   - [xsel](https://github.com/kfish/xsel.git)
 - For Wayland
   - [wl-clipboard](https://github.com/bugaevc/wl-clipboard.git)
 - Cross Compatible
   - [CopyQ](https://github.com/hluk/CopyQ.git)
 
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - If you have it, set `vim.g.have_nerd_font` in `init.lua` to true

#### Configs

Neovim's configurations are located under 

- `$XDG_CONFIG_HOME/nvim`
- `~/.config/nvim`

### Post Install

Start Neovim:
`nvim`

View plugin status: 
`:Lazy` 

#### Maybe

- You may want to remove `lazy-lock.json` from your fork's `.gitignore` file
- It's ignored in kickstart repo to make maintenance easier, but - is
[recommended to track it in version control](https://lazy.folke.io/usage/lockfile).


#### Read The Friendly Documentation

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.


### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### Tips

Use `NVIM_APPNAME` to maintain multiple configurations.

[NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`

For example:
You can install the kickstart configuration in `~/.config/nvim-kickstart` and create an alias:
```sh
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
```
    
When you run Neovim using `nvim-kickstart` alias it will use the alternative config directory and the matching local directory `~/.local/share/nvim-kickstart`.

Apply to any Neovim distribution you'd like to try out.


## Config Base
For my config base, I used with `Kickstart`
Now the config is heavily modified;

It's hardly a `kickstart` config anymore, other than having used that as source, for the initial set of plugins... 

If you're looking for where to start your own config. Start there

#### Kickstart
Original kickstart repo with the single `init.lua` file is available here:
 - [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
#### Kickstart Modular
- [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
*NOTE: This fork splits the configuration into smaller parts.*


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

