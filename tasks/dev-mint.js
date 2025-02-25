// tasks/devMint.js
const { task } = require("hardhat/config");

task("dev-mint", "Batch mints tokens using devMint")
  .addParam("contract", "The deployed HyperFrogs contract address")
  .addParam("quantity", "The number of tokens to mint")
  .setAction(async (taskArgs, hre) => {
    const { contract, quantity } = taskArgs;
    
    // Get the contract factory and attach to the deployed contract.
    const HyperFrogs = await hre.ethers.getContractFactory("HyperFrogs");
    const hyperFrogs = HyperFrogs.attach(contract);
    
    // Use the default signer (ensure this address has DEFAULT_ADMIN_ROLE)
    const [admin] = await hre.ethers.getSigners();
    
    console.log(`Initiating devMint of ${quantity} tokens from ${admin.address}...`);
    
    // Call the devMint function
    const tx = await hyperFrogs.connect(admin).devMint(quantity);
    console.log(`Transaction hash: ${tx.hash}`);
    
    // Wait for the transaction to be mined
    const receipt = await tx.wait();
    console.log(`Successfully minted ${quantity} tokens in block ${receipt.blockNumber}`);
  });

module.exports = {};

// Mainnet
// npx hardhat dev-mint --contract 0x4Adb7665C72ccdad25eD5B0BD87c34e4Ee9Da3c4 --quantity 3 --network hyperliquid_mainnet

// Testnet
// npx hardhat dev-mint --contract 0x5bB638Ea28314116514daa924310E9575C3a78f8 --quantity 1 --network hyperliquid_testnet
