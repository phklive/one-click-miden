# One Click Miden

Welcome to the **One Click Miden**! This script automates the installation and initialization of the Miden CLI, ensuring you have everything you need to start working with Miden!

Simply run the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/phklive/miden.sh/refs/heads/main/miden.sh | sh
```

## Table of Contents

- [Script Details](#script-details)
- [Next Steps](#next-steps)
- [License](#license)

## Script details

This script performs the following actions:

- **Checks for Rust installation** and offers to install it if not present.
- **Ensures Cargo is in the system's PATH**.
- **Prevents overwriting** by checking if the `miden` directory already exists.
- **Installs the `miden-cli` tool** with specified features.
- **Initializes Miden** with a provided RPC address.
- **Creates a new mutable wallet**.
- **Displays a welcome ASCII art message**.
- **Lists available accounts**.
- **Provides useful resources and next steps**.

## Next Steps

After running the script:

- **Visit the Testnet Faucet** to get testnet funds: [https://testnet.miden.io/](https://testnet.miden.io/)
- **Read the Documentation** to learn more about Miden: [https://docs.polygon.technology/miden/](https://docs.polygon.technology/miden/)
- **Explore the Codebase** on GitHub: [https://github.com/0xPolygonMiden](https://github.com/0xPolygonMiden)
- **Try out the Playground** with examples: [https://0xpolygonmiden.github.io/examples/](https://0xpolygonmiden.github.io/examples/)

## License

This script is open-source and available under the MIT [License](./LICENSE). Feel free to modify and distribute it as per the license terms.
