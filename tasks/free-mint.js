const { task } = require("hardhat/config");
require("dotenv").config();

task("free-mint", "Calls free_mint on the deployed HyperFrogs contract")
  .addParam("contract", "The deployed HyperFrogs contract address")
  .setAction(async (taskArgs, hre) => {
    const { ethers } = hre;
    const contractAddress = taskArgs.contract;
    
    // Attach to the deployed HyperFrogs contract
    const HyperFrogs = await ethers.getContractFactory("HyperFrogs");
    const hyperFrogs = HyperFrogs.attach(contractAddress);
    console.log("Using HyperFrogs contract at:", contractAddress);
    
    console.log("Calling free_mint()...");
    const tx = await hyperFrogs.free_mint();
    console.log("Transaction hash:", tx.hash);
    await tx.wait();
    console.log("Free mint transaction confirmed!");
    
    const totalSupply = await hyperFrogs.totalSupply();
    console.log("Total supply after free mint:", totalSupply.toString());
  });

module.exports = {};

// Mainnet
// npx hardhat free-mint --contract 0x4Adb7665C72ccdad25eD5B0BD87c34e4Ee9Da3c4 --network hyperliquid_mainnet

// Testnet
// npx hardhat free-mint --contract 0x5bB638Ea28314116514daa924310E9575C3a78f8 --network hyperliquid_testnet
