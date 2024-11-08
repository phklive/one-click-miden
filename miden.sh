#!/bin/bash

# Define color variables
PURPLE="\e[38;2;126;90;198m"
RESET="\e[0m"

# Function to print messages in purple with a newline under them
print() {
    echo ""
    echo "$1"
    echo ""
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Rust
install_rust() {
    print "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # Source the environment to make Rust available in the current session
    source "$HOME/.cargo/env"
}

# Check if Rust is installed
if command_exists rustc; then
    print "✅ Rust is installed."
    # Update Rust to the latest version
    print "🔄 Updating Rust to the latest version..."
    rustup update
else
    print "❌ Rust is not installed."
    read -p "$(echo -e "${PURPLE}Do you want to install Rust? [Y/n]${RESET} ")" -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ || -z $REPLY ]]; then
        install_rust
    else
        print "⚠️ Rust is required to proceed. Exiting."
        exit 1
    fi
fi

# Ensure cargo is in PATH
if ! command_exists cargo; then
    print "ℹ️ Cargo is not found in PATH. Adding it..."
    source "$HOME/.cargo/env"
fi

# Check if 'miden' directory already exists
if [ -d "miden" ]; then
    print "❌ The 'miden' directory already exists. Please remove it."
    exit 1
fi

# Create miden directory and navigate into it
print "📁 Creating and entering the 'miden' directory..."
mkdir -p miden

cd miden

# Install miden-cli with specified features
print "⬇️ Installing miden-cli..."
cargo install miden-cli --features testing,concurrent

# Ensure miden-cli was installed successfully
if ! command_exists miden; then
    print "❌ Failed to install miden-cli. Exiting."
    exit 1
fi

# Initialize miden with the provided RPC address
print "🔧 Initializing miden..."
miden init --rpc 18.203.155.106

# Create a new mutable wallet
print "💼 Creating a new mutable wallet..."
miden new-wallet --mutable

print "✅ Setup complete!"

print "🔗 Next steps go to:"
print "Testnet faucet -> https://testnet.miden.io/"
print "Documentation -> https://docs.polygon.technology/miden/"
print "Codebase -> https://github.com/0xPolygonMiden"
print "Playground -> https://0xpolygonmiden.github.io/examples/"

# Welcome user
echo " __        __   _                            _          " 
echo " \\ \\      / /__| | ___ ___  _ __ ___   ___  | |_ ___    __  __ ___ ___  ___  _  _   "
echo "  \\ \\ /\\ / / _ \\ |/ __/ _ \\| '_ \` _ \\ / _ \\ | __/ _ \\  |  \\/  |_ _|   \\| __|| \\| |  "
echo "   \\ V  V /  __/ | (_| (_) | | | | | |  __/ | || (_) | | |\\/| || || |) | _| | .\` |   "
echo "    \\_/\\_/ \\___|_|\\___\\___/|_| |_| |_|\\___|  \\__\\___/  |_|  |_|___|___/|___||_|\\_|   "

print "Fasten your seatbelts! We're about to take off into the world of privacy!"

# List accounts
print "📄 Listing accounts..."
miden account -l
