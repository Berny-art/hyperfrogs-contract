const { task } = require("hardhat/config");
require("dotenv").config();

task("set-max-mint-per-wallet", "Sets the maximum mints allowed per wallet")
  .addParam("contract", "The deployed HyperFrogs contract address")
  .addParam("max", "The new maximum mints per wallet")
  .setAction(async (taskArgs, hre) => {
    const { ethers } = hre;
    const contractAddress = taskArgs.contract;
    const newMax = taskArgs.max;
    
    const HyperFrogs = await ethers.getContractFactory("HyperFrogs");
    const hyperFrogs = HyperFrogs.attach(contractAddress);
    
    console.log(`Setting max mint per wallet to ${newMax} on contract ${contractAddress}`);
    const tx = await hyperFrogs.setMaxMintPerWallet(newMax);
    console.log("Transaction sent:", tx.hash);
    await tx.wait();
    console.log("✅ Max mint per wallet updated successfully!");
  });

module.exports = {};

// Mainnet
// npx hardhat set-max-mint-per-wallet --contract 0x4Adb7665C72ccdad25eD5B0BD87c34e4Ee9Da3c4 --max 5 --network hyperliquid_mainnet