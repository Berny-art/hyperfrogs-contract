Hyper Frogs Contract
Hyper Frogs is an on-chain NFT project that dynamically generates SVG images entirely on-chain by assembling multiple trait contracts. The contract utilizes advanced Solidity techniques such as weighted random trait selection, on-chain SVG generation, and role-based access control with OpenZeppelin's AccessControl.

Features
On-Chain SVG Generation:
Assemble SVG images using various trait contracts (Body, Hats, Eyes, Mouth, Feet, Backdrop) entirely on-chain. Traits are combined dynamically based on random seeds and weighted probabilities.

Trait Management:

Supports multiple variants per trait.
Merges two separate eyes contracts (FrogsEyesA and FrogsEyesB) into a single selection process.
Probabilities are used to determine trait rarity.
Role-Based Access Control:
Utilizes OpenZeppelin's AccessControl so that the deployer is automatically assigned the DEFAULT_ADMIN_ROLE and CONTROLLER_ROLE. Admins can toggle minting, set mint prices, and manage whitelists.

Minting & Free Minting:
Standard minting functions are available along with a free mint option for whitelisted addresses.

Rarity Distribution Simulation:
A suite of tests simulates multiple mints and outputs a formatted, horizontal table (using console.table) to help visualize the rarity distribution of each trait.

Installation
Make sure you have Node.js installed. Then clone the repository and install dependencies:

bash
Kopiëren
git clone https://github.com/yourusername/hyper-frogs.git
cd hyper-frogs
npm install
Usage
Hardhat Tasks
This project uses Hardhat for development and testing. Some useful commands are:

bash
Kopiëren
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
Deployment
Configure your network settings in hardhat.config.js, then deploy the Hyper Frogs contract with:

bash
Kopiëren
npx hardhat run scripts/deploy.js --network <network_name>
Testing Trait Distribution
A special test simulates minting (e.g., 100 tokens) and aggregates the rarity of each trait. It then outputs a formatted horizontal table in the CLI showing trait names, counts, and percentages—useful for verifying your rarity setup.

Project Structure
contracts/
Contains Solidity source code for the HyperFrogs contract and all associated trait contracts (FrogsBody, FrogsHats, FrogsEyesA, FrogsEyesB, FrogsMouth, FrogsFeet, FrogsBackdrop).

test/
Hardhat test files covering functionality including minting, SVG generation, and rarity simulation.

scripts/
Deployment scripts for the contracts.

ignition/
Hardhat Ignition modules for deployment (if using the Ignition plugin).

Contributing
Contributions are welcome! If you have ideas for improvements or bug fixes, please open an issue or submit a pull request.

License
This project is licensed under the MIT License.