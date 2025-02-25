const { task } = require("hardhat/config");
const fs = require("node:fs");
require("dotenv").config();

task("add-freelist", "Adds addresses from a text file to the free list")
  .addParam("contract", "The deployed HyperFrogs contract address")
  .setAction(async (taskArgs, hre) => {
    const { ethers } = hre;
    const contractAddress = taskArgs.contract;

    // Attach to the deployed HyperFrogs contract
    const HyperFrogs = await ethers.getContractFactory("HyperFrogs");
    const hyperFrogs = HyperFrogs.attach(contractAddress);
    console.log("Using HyperFrogs contract at:", contractAddress);

    // Read addresses from the free list file
    const filePath = "./tasks/whitelists/freelist.txt";
    let fileData;
    try {
      fileData = fs.readFileSync(filePath, "utf8");
    } catch (err) {
      console.error(`Error reading file at ${filePath}:`, err);
      process.exit(1);
    }
    
    // Split by newlines, trim, and filter out empty lines
    const addresses = fileData.split(/\r?\n/).map(line => line.trim()).filter(line => line !== "");
    console.log(`Total free list addresses found: ${addresses.length}`);

    // Call addToFreeList (assuming it accepts an array of addresses)
    console.log("Adding addresses to free list...");
    const tx = await hyperFrogs.addToFreeList(addresses);
    console.log("Transaction sent. Hash:", tx.hash);
    await tx.wait();
    console.log("✅ All addresses added to free list.");
  });

module.exports = {};

// Mainnet
// npx hardhat add-freelist --contract 0x4Adb7665C72ccdad25eD5B0BD87c34e4Ee9Da3c4 --network hyperliquid_mainnet

// Testnet
// npx hardhat add-freelist --contract 0x5bB638Ea28314116514daa924310E9575C3a78f8 --network hyperliquid_testnet