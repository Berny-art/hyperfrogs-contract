// tasks/setWhitelistDuration.js
const { task } = require("hardhat/config");
require("dotenv").config();

task(
  "set-whitelist-duration",
  "Set the whitelist duration in seconds"
)
  .addParam("contract", "The deployed HyperFrogs contract address")
  .addOptionalParam("duration", "Whitelist duration in seconds (default 25200 seconds for 7 hours)", "25200")
  .setAction(async (taskArgs, hre) => {
    const { ethers } = hre;

    const duration = Number.parseInt(taskArgs.duration);
    console.log(`Setting whitelist duration to ${duration} seconds...`);

    // Get the contract factory
    const HyperFrogs = await ethers.getContractFactory("HyperFrogs");

    // Attach to the deployed contract
    const hyperFrogs = HyperFrogs.attach(taskArgs.contract);

    // Get signer (admin with DEFAULT_ADMIN_ROLE)
    const [admin] = await ethers.getSigners();

    // Send the transaction
    try {
      const txDuration = await hyperFrogs.connect(admin).setWhitelistDuration(duration);
      console.log(`Transaction hash: ${txDuration.hash}`);
      await txDuration.wait();
      console.log("✅ Whitelist duration set successfully.");
    } catch (error) {
      console.error("❌ Failed to set whitelist duration:", error);
    }
  });

module.exports = {};

// Mainnet
// npx hardhat set-whitelist-duration --contract 0x4Adb7665C72ccdad25eD5B0BD87c34e4Ee9Da3c4 --network hyperliquid_mainnet

