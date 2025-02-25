const { task } = require("hardhat/config");
require("dotenv").config();

task("toggle-mint", "Toggles minting on/off for the HyperFrogs contract (normal or free mint)")
  .addParam("contract", "The deployed HyperFrogs contract address")
  .addOptionalParam("mode", "Mint mode to toggle: 'free' or 'normal' (default is 'normal')", "normal")
  .setAction(async (taskArgs, hre) => {
    const { ethers } = hre;
    const contractAddress = taskArgs.contract;
    const mode = taskArgs.mode.toLowerCase();

    // Get contract instance
    const HyperFrogs = await ethers.getContractFactory("HyperFrogs");
    const hyperFrogs = HyperFrogs.attach(contractAddress);

    // Check current status and log it
    if (mode === "free") {
      const currentStatus = await hyperFrogs.freeMintEnabled();
      console.log("Current freeMintEnabled status:", currentStatus);
    } else {
      const currentStatus = await hyperFrogs.mintEnabled();
      console.log("Current mintEnabled status:", currentStatus);
    }

    // Toggle the corresponding minting mode
    let tx;
    if (mode === "free") {
      console.log("Toggling free minting...");
      tx = await hyperFrogs.toggleFreeMinting();
    } else {
      console.log("Toggling normal minting...");
      tx = await hyperFrogs.toggleMinting();
    }
    console.log("Transaction sent:", tx.hash);
    await tx.wait();

    // Fetch and log the new status
    if (mode === "free") {
      const newStatus = await hyperFrogs.freeMintEnabled();
      console.log("New freeMintEnabled status:", newStatus);
    } else {
      const newStatus = await hyperFrogs.mintEnabled();
      console.log("New mintEnabled status:", newStatus);
    }
  });

module.exports = {};

// Mainnet
// npx hardhat toggle-mint --contract 0x4Adb7665C72ccdad25eD5B0BD87c34e4Ee9Da3c4 --network hyperliquid_mainnet
// npx hardhat toggle-mint --contract 0x4Adb7665C72ccdad25eD5B0BD87c34e4Ee9Da3c4 --mode free --network hyperliquid_mainnet

// Testnet
// npx hardhat toggle-mint --contract 0x5bB638Ea28314116514daa924310E9575C3a78f8 --network hyperliquid_testnet
// npx hardhat toggle-mint --contract 0x5bB638Ea28314116514daa924310E9575C3a78f8 --mode free --network hyperliquid_testnet
