# AstroNvim custom configuration

## Helper Script

```bash
#!/bin/bash
NVIM_VERSION="v0.9.0"
NODE_VERSION="lts/hydrogen"
TF_VERSION="1.4.5"
TG_VERSION="0.45.3"
GO_VERSION="1.20.3"
help() {
    echo "Manage provisioning of NeoVim on Ubuntu"
    echo
    echo "Syntax: source ./provision_neovim.sh [-h|d|c|n|a]"
    echo "options:"
    echo "h         Print this Help."
    echo "d         Install All dependencies"
    echo "c         Uninstall Neovim framework"
    echo "n         Install NvChad"
    echo "a         Install AstroNvim"
    echo
}

install_system_deps() {
    sudo apt update
    sudo apt install -y \
        git \
        curl \
        zip \
        unzip \
        wget \
        python3 \
        python3-pip \
        python3-venv \
        ripgrep
}

install_neovim() {
    wget https://github.com/neovim/neovim/releases/download/"$1"/nvim-linux64.tar.gz
    tar -xvzf nvim-linux64.tar.gz
    mv nvim-linux64 .nvim-linux64
    ln -s "$HOME"/.nvim-linux64/bin/nvim /usr/bin/nvim
    rm -rf nvim-linux64.tar.gz
}

install_node() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    # shellcheck source=/dev/null
    source ~/.bashrc
    nvm install "$1"
}

install_terraform() {
    git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
    ln -s ~/.tfenv/bin/* /usr/local/bin
    tfenv install "$1" && tfenv use "$1"
}

install_terragrunt() {
    git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv
    ln -s ~/.tgenv/bin/* /usr/local/bin
    tgenv install "$1" && tgenv use "$1"
}

install_go() {
    wget https://go.dev/dl/go"$1".linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go"$1".linux-amd64.tar.gz
    echo "export PATH=\$PATH:/usr/local/go/bin" >>~/.bashrc
}

install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}

remove_nvim_config() {
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.cache/nvim
}

install_nvchad() {
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
    git clone https://github.com/DawiX/nvchad-custom.git ~/.config/nvim/lua/config
}

install_astronvim() {
    git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
    git clone https://github.com/DawiX/astrovim-user-overrides.git ~/.config/nvim/lua/user
}

DEPS="false"
UNINSTALL="false"
NVCHAD="false"
ASTRO="false"

while getopts ":hdcna" option; do
    case $option in
    h)
        help
        exit 1
        ;;
    d)
        DEPS="true"
        ;;
    c)
        UNINSTALL="true"
        ;;
    n)
        NVCHAD="true"
        ;;
    a)
        ASTRO="true"
        ;;
    \?)
        echo "Error: Invalid option"
        help
        exit 1
        ;;
    esac
done

if [ "$OPTIND" -eq 1 ]; then help exit 1; fi

if [ "$UNINSTALL" == "true" ]; then
    echo "Removing Neovim Configs"
    remove_nvim_config
fi

if [ "$DEPS" == "true" ]; then
    echo "Installing dependencies"
    install_system_deps
    install_neovim "$NVIM_VERSION"
    install_node "$NODE_VERSION"
    install_terraform "$TF_VERSION"
    install_terragrunt "$TG_VERSION"
    install_go "$GO_VERSION"
    install_rust
fi
if [ "$NVCHAD" == "true" ]; then
    echo "Installing Nvchad"
    install_nvchad
fi
if [ "$ASTRO" == "true" ]; then
    echo "Installing AstroNvim"
    install_astronvim
fi
```
