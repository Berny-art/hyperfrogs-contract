const { task } = require("hardhat/config");
const fs = require("node:fs");
require("dotenv").config();

task("batch-add-whitelist", "Adds addresses from a text file to the whitelist in batches")
  .addParam("contract", "The deployed HyperFrogs contract address")
  .addOptionalParam("batchSize", "Number of addresses to add per transaction", "1000")
  .setAction(async (taskArgs, hre) => {
    const { ethers } = hre;
    const contractAddress = taskArgs.contract;
    const batchSize = Number.parseInt(taskArgs.batchSize);

    // Attach to the deployed HyperFrogs contract
    const HyperFrogs = await ethers.getContractFactory("HyperFrogs");
    const hyperFrogs = HyperFrogs.attach(contractAddress);
    console.log("Using deployed HyperFrogs contract at:", contractAddress);

    // Read addresses from the file
    const filePath = "./tasks/whitelists/whitelist.txt";
    let fileData;
    try {
      fileData = fs.readFileSync(filePath, "utf8");
    } catch (err) {
      console.error(`Error reading file at ${filePath}:`, err);
      process.exit(1);
    }
    
    // Filter addresses: ensure each is non-empty and valid
    const addresses = fileData
      .split(/\r?\n/)
      .map(line => line.trim())
      .filter(line => {
        if (line === "") return false;
        if (!ethers.isAddress(line)) {
          console.warn(`Invalid address skipped: ${line}`);
          return false;
        }
        return true;
      });
    console.log(`Total valid addresses found: ${addresses.length}`);

    // Process addresses in batches
    let batchNumber = 1;
    for (let i = 0; i < addresses.length; i += batchSize) {
      const batch = addresses.slice(i, i + batchSize);
      console.log(`Adding batch ${batchNumber}: addresses ${i} to ${i + batch.length - 1}`);
      const tx = await hyperFrogs.addToWhitelist(batch);
      console.log(`Batch ${batchNumber} transaction hash: ${tx.hash}`);
      await tx.wait();
      console.log(`Batch ${batchNumber} added successfully.`);
      batchNumber++;
    }
    console.log("✅ All addresses added to whitelist.");
  });

module.exports = {};

// Mainnet
// npx hardhat batch-add-whitelist --contract 0x4Adb7665C72ccdad25eD5B0BD87c34e4Ee9Da3c4 --network hyperliquid_mainnet

// Testnet
//npx hardhat batch-add-whitelist --contract 0x5bB638Ea28314116514daa924310E9575C3a78f8 --network hyperliquid_testnet
