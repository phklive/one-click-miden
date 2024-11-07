#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Rust
install_rust() {
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # Source the environment to make Rust available in the current session
    source "$HOME/.cargo/env"
}

# Check if Rust is installed
if command_exists rustc; then
    echo "✅ Rust is installed."
    # Update Rust to the latest version
    echo "🔄 Updating Rust to the latest version..."
    rustup update
else
    echo "❌ Rust is not installed."
    read -p "Do you want to install Rust? [Y/n] " -n 1 -r
    echo    # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ || -z $REPLY ]]; then
        install_rust
    else
        echo "⚠️ Rust is required to proceed. Exiting."
        exit 1
    fi
fi

# Ensure cargo is in PATH
if ! command_exists cargo; then
    echo "ℹ️ Cargo is not found in PATH. Adding it..."
    source "$HOME/.cargo/env"
fi

# Create miden directory and navigate into it
echo "📁 Creating and entering the 'miden' directory..."
mkdir -p miden && cd miden

# Install miden-cli with specified features
echo "⬇️ Installing miden-cli..."
cargo install miden-cli --features testing,concurrent

# Ensure miden-cli was installed successfully
if ! command_exists miden; then
    echo "❌ Failed to install miden-cli. Exiting."
    exit 1
fi

# Initialize miden with the provided RPC address
echo "🔧 Initializing miden..."
miden init --rpc 18.203.155.106

# Create a new mutable wallet
echo "💼 Creating a new mutable wallet..."
miden new-wallet --mutable

# List accounts
echo "📄 Listing accounts..."
miden account -l

echo "✅ Setup complete!"
