const { task } = require("hardhat/config");
require("dotenv").config();

task("deploy", "Deploys trait contracts and HyperFrogs contract")
  .setAction(async (taskArgs, hre) => {
    const { ethers } = hre;

    const gasLimit = 29500000; // Set to 29.5M gas limit

    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with:", deployer.address);

    const balance = await ethers.provider.getBalance(deployer.address);
    console.log("Deployer balance:", ethers.formatEther(balance), "ETH");

    //======== Deploy Trait Contracts One by One ========
    console.log("Deploying FrogsBody...");
    const FrogsBody = await ethers.getContractFactory("FrogsBody");
    const frogsBody = await FrogsBody.deploy({ gasLimit });
    await frogsBody.waitForDeployment();
    console.log("FrogsBody deployed to:", await frogsBody.getAddress());

    console.log("Deploying FrogsHats...");
    const FrogsHats = await ethers.getContractFactory("FrogsHats");
    const frogsHats = await FrogsHats.deploy({ gasLimit });
    await frogsHats.waitForDeployment();
    console.log("FrogsHats deployed to:", await frogsHats.getAddress());

    console.log("Deploying FrogsEyesA...");
    const FrogsEyesA = await ethers.getContractFactory("FrogsEyesA");
    const frogsEyesA = await FrogsEyesA.deploy({ gasLimit });
    await frogsEyesA.waitForDeployment();
    console.log("FrogsEyesA deployed to:", await frogsEyesA.getAddress());

    console.log("Deploying FrogsEyesB...");
    const FrogsEyesB = await ethers.getContractFactory("FrogsEyesB");
    const frogsEyesB = await FrogsEyesB.deploy({ gasLimit });
    await frogsEyesB.waitForDeployment();
    console.log("FrogsEyesB deployed to:", await frogsEyesB.getAddress());

    console.log("Deploying FrogsMouth...");
    const FrogsMouth = await ethers.getContractFactory("FrogsMouth");
    const frogsMouth = await FrogsMouth.deploy({ gasLimit });
    await frogsMouth.waitForDeployment();
    console.log("FrogsMouth deployed to:", await frogsMouth.getAddress());

    console.log("Deploying FrogsFeet...");
    const FrogsFeet = await ethers.getContractFactory("FrogsFeet");
    const frogsFeet = await FrogsFeet.deploy({ gasLimit });
    await frogsFeet.waitForDeployment();
    console.log("FrogsFeet deployed to:", await frogsFeet.getAddress());

    console.log("Deploying FrogsBackdrop...");
    const FrogsBackdrop = await ethers.getContractFactory("FrogsBackdrop");
    const frogsBackdrop = await FrogsBackdrop.deploy({ gasLimit });
    await frogsBackdrop.waitForDeployment();
    console.log("FrogsBackdrop deployed to:", await frogsBackdrop.getAddress());

    console.log("Deploying FrogsOneOfOne...");
    const FrogsOneOfOne = await ethers.getContractFactory("FrogsOneOfOne");
    const frogsOneOfOne = await FrogsOneOfOne.deploy({ gasLimit });
    await frogsOneOfOne.waitForDeployment();
    console.log("FrogsOneOfOne deployed to:", await frogsOneOfOne.getAddress());

    // ======== Deploy HyperFrogs Contract Last ========
    console.log("Deploying HyperFrogs...");
    const HyperFrogs = await ethers.getContractFactory("HyperFrogs");
    const hyperFrogs = await HyperFrogs.deploy(
      await frogsBody.getAddress(),
      await frogsHats.getAddress(),
      await frogsEyesA.getAddress(),
      await frogsEyesB.getAddress(),
      await frogsMouth.getAddress(),
      await frogsFeet.getAddress(),
      await frogsBackdrop.getAddress(),
      await frogsOneOfOne.getAddress(),
      { gasLimit }
    );
    await hyperFrogs.waitForDeployment();
    console.log("HyperFrogs deployed to:", await hyperFrogs.getAddress());

    // ======== Save Deployed Addresses ========
    const fs = require("node:fs");
    const addresses = {
      FrogsBody: await frogsBody.getAddress(),
      FrogsHats: await frogsHats.getAddress(),
      FrogsEyesA: await frogsEyesA.getAddress(),
      FrogsEyesB: await frogsEyesB.getAddress(),
      FrogsMouth: await frogsMouth.getAddress(),
      FrogsFeet: await frogsFeet.getAddress(),
      FrogsBackdrop: await frogsBackdrop.getAddress(),
      FrogsOneOfOne: await frogsOneOfOne.getAddress(),
      HyperFrogs: await hyperFrogs.getAddress(),
    };

    fs.writeFileSync("./deployed_addresses.json", JSON.stringify(addresses, null, 2));
    console.log("✅ All contract addresses saved to deployed_addresses.json");
  });

module.exports = {};
