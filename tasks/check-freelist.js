// tasks/checkFreeList.js
const { task } = require("hardhat/config");

task("check-free-list", "Checks if an account is on the free list and the free mint status")
  .addParam("contract", "The deployed HyperFrogs contract address")
  .addParam("account", "The account address to check")
  .setAction(async (taskArgs, hre) => {
    const { contract, account } = taskArgs;

    // Get the contract factory and attach to the deployed contract.
    const HyperFrogs = await hre.ethers.getContractFactory("HyperFrogs");
    const hyperFrogs = HyperFrogs.attach(contract);

    // Query the freeList mapping and free mint status.
    const isOnFreeList = await hyperFrogs.freeList(account);
    const isOnWhitelist = await hyperFrogs.whitelist(account);
    const freeMintStatus = await hyperFrogs.freeMintEnabled();
    const mintStatus = await hyperFrogs.mintEnabled();
    const freeCount = await hyperFrogs.freeCount();

    console.log(`Address ${account} is ${isOnFreeList ? "on" : "not on"} the free list`);
    console.log(`Address ${account} is ${isOnWhitelist ? "on" : "not on"} the whitelist`);
    console.log(`Free minting is currently ${freeMintStatus ? "enabled" : "disabled"}`);
    console.log(`Normal minting is currently ${mintStatus ? "enabled" : "disabled"}`);
    
    console.log(`There are ${freeCount} free mints completed`);
  });

module.exports = {};

// Mainnet
// npx hardhat check-free-list --contract 0x4Adb7665C72ccdad25eD5B0BD87c34e4Ee9Da3c4 --account 0xaacDF5D6b6dF6215d895a3F8E6398AfF35E3b2Cf --network hyperliquid_mainnet
// npx hardhat check-free-list --contract 0x4Adb7665C72ccdad25eD5B0BD87c34e4Ee9Da3c4 --account 0x01052b98dE749b7331b9F8FF8b283241E12Dd55E --network hyperliquid_mainnet

// Testnet
// npx hardhat check-free-list --contract 0x5bB638Ea28314116514daa924310E9575C3a78f8 --account 0xaacDF5D6b6dF6215d895a3F8E6398AfF35E3b2Cf --network hyperliquid_testnet