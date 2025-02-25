# Hyper Frogs Contract

Hyper Frogs is an on-chain NFT project that dynamically generates SVG images entirely on-chain by assembling multiple trait contracts. The main contract handles minting, SVG generation, and rarity distribution, while separate trait contracts provide the art layers.

> **Important:**  
> The art layers contained in the `traits/` folder are **proprietary**. They are for use only within the Hyper Frogs project. **No one may reuse, copy, distribute, or sell these art layers** in any form without explicit written permission from the author.

## Features

- **On-Chain SVG Generation:**  
  Assemble dynamic SVG images entirely on-chain using multiple trait contracts (Body, Hats, Eyes, Mouth, Feet, Backdrop).

- **Trait Management:**  
  - Supports multiple variants per trait.  
  - Merges two separate Eyes contracts (FrogsEyesA and FrogsEyesB) into a single selection process using weighted random probabilities.

- **Role-Based Access Control:**  
  Uses OpenZeppelin’s AccessControl. The deployer is assigned the `DEFAULT_ADMIN_ROLE` and `CONTROLLER_ROLE`, enabling management of minting, whitelists, and other administrative tasks.

- **Minting & Free Minting:**  
  Standard minting is supported along with a free mint option for whitelisted addresses.

- **Rarity Distribution Simulation:**  
  Tests simulate a batch mint and output formatted tables in the CLI to display the overall rarity distribution of each trait.

## Installation

Ensure you have [Node.js](https://nodejs.org/) installed. Then, clone the repository and install dependencies:

```bash
git clone https://github.com/yourusername/hyper-frogs.git
cd hyper-frogs
npm install
```

## Usage
This project uses Hardhat for development and testing. Here are some useful commands:

```bash
# Display Hardhat help
npx hardhat help

# Run tests
npx hardhat test

# Run tests with gas reporting
REPORT_GAS=true npx hardhat test

# Start a local Hardhat node
npx hardhat node

# Deploy using Hardhat Ignition (if configured)
npx hardhat ignition deploy ./ignition/modules/Lock.js
```

## Deployment
Configure your network settings in hardhat.config.js and deploy the contract:

```bash
npx hardhat deploy --network <network_name>
```

## Tasks

```bash
npx hardhat batch-add-whitelist --contract <Your_HyperFrogs_Contract_Address> --network <network_name>

npx hardhat withdraw-funds --contract 0xYourDeployedHyperFrogsAddress --network <network_name>

npx hardhat enable-minting --contract 0xYourDeployedHyperFrogsAddress --network <network_name>
```

## Rarity Distribution Simulation
A test script simulates minting (e.g., 100 tokens) and aggregates the occurrence of each trait. It outputs a horizontal table (using console.table) showing each trait's name, count, and percentage. This helps verify that your rarity distributions match your intended design.

## Contributing
Contributions are welcome for improving the core functionality and tests. However, please note that the art layers in the traits/ folder are proprietary and cannot be modified or redistributed without permission.

## License
Main Contract: Licensed under the MIT License.
Traits (Art Layers): Proprietary. The art layers are not to be reused, copied, or sold without explicit written permission.