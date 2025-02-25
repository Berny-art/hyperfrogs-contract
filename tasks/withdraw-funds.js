const { task } = require("hardhat/config");
require("dotenv").config();

task("withdraw-funds", "Withdraws funds from the HyperFrogs contract")
  .addParam("contract", "The deployed HyperFrogs contract address")
  .setAction(async (taskArgs, hre) => {
    const { ethers } = hre;
    const contractAddress = taskArgs.contract;

    // Use the deployer (or admin) account
    const [deployer] = await ethers.getSigners();
    console.log("Using deployer:", deployer.address);

    // Attach to the HyperFrogs contract using its factory
    const HyperFrogs = await ethers.getContractFactory("HyperFrogs");
    const hyperFrogs = HyperFrogs.attach(contractAddress);
    console.log("Attached to HyperFrogs at:", contractAddress);

    // Call the withdraw() function (must be called by admin)
    console.log("Calling withdraw...");
    const tx = await hyperFrogs.withdraw();
    console.log("Transaction sent. Hash:", tx.hash);

    // Wait for the transaction to be confirmed
    await tx.wait();
    console.log("✅ Funds withdrawn successfully!");
  });

module.exports = {};

// Testnet
// npx hardhat withdraw-funds --contract 0x4Adb7665C72ccdad25eD5B0BD87c34e4Ee9Da3c4 --network hyperliquid_mainnet

// Testnet
// npx hardhat withdraw-funds --contract 0x5bB638Ea28314116514daa924310E9575C3a78f8 --network hyperliquid_testnet