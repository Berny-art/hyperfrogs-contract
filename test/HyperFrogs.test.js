const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("HyperFrogs Contract", () => {
  let HyperFrogs;
  let hyperFrogs;
  let deployer;
  let addr1;
  let addr2;
  let frogsBody;
  let frogsHats;
  let frogsEyesA;
  let frogsEyesB;
  let frogsMouth;
  let frogsFeet;
  let frogsBackdrop;
  let frogsOneOfOne;

  beforeEach(async () => {
    [deployer, addr1, addr2] = await ethers.getSigners();

    // Deploy trait contracts
    const FrogsBody = await ethers.getContractFactory("FrogsBody");
    frogsBody = await FrogsBody.deploy();
    await frogsBody.waitForDeployment();

    const FrogsHats = await ethers.getContractFactory("FrogsHats");
    frogsHats = await FrogsHats.deploy();
    await frogsHats.waitForDeployment();

    const FrogsEyesA = await ethers.getContractFactory("FrogsEyesA");
    frogsEyesA = await FrogsEyesA.deploy();
    await frogsEyesA.waitForDeployment();

    const FrogsEyesB = await ethers.getContractFactory("FrogsEyesB");
    frogsEyesB = await FrogsEyesB.deploy();
    await frogsEyesB.waitForDeployment();

    const FrogsMouth = await ethers.getContractFactory("FrogsMouth");
    frogsMouth = await FrogsMouth.deploy();
    await frogsMouth.waitForDeployment();

    const FrogsFeet = await ethers.getContractFactory("FrogsFeet");
    frogsFeet = await FrogsFeet.deploy();
    await frogsFeet.waitForDeployment();

    const FrogsBackdrop = await ethers.getContractFactory("FrogsBackdrop");
    frogsBackdrop = await FrogsBackdrop.deploy();
    await frogsBackdrop.waitForDeployment();

    const FrogsOneOfOne = await ethers.getContractFactory("FrogsOneOfOne");
    frogsOneOfOne = await FrogsOneOfOne.deploy();
    await frogsOneOfOne.waitForDeployment();

    // Optionally, check that each trait contract has a valid address.
    expect(frogsBody.target).to.properAddress;
    expect(frogsHats.target).to.properAddress;
    expect(frogsEyesA.target).to.properAddress;
    expect(frogsEyesB.target).to.properAddress;
    expect(frogsMouth.target).to.properAddress;
    expect(frogsFeet.target).to.properAddress;
    expect(frogsBackdrop.target).to.properAddress;
    expect(frogsOneOfOne.target).to.properAddress;

    // Deploy HyperFrogs with the addresses of the trait contracts.
    HyperFrogs = await ethers.getContractFactory("HyperFrogs");
    hyperFrogs = await HyperFrogs.deploy(
      frogsBody.target,
      frogsHats.target,
      frogsEyesA.target,
      frogsEyesB.target,
      frogsMouth.target,
      frogsFeet.target,
      frogsBackdrop.target,
      frogsOneOfOne.target
    );
    await hyperFrogs.waitForDeployment();
  });

  it("Should deploy with correct initial values", async () => {
    expect(await hyperFrogs.maxSupply()).to.equal(2222);
    expect(await hyperFrogs.mintPrice()).to.equal(ethers.parseEther("1.0"));
    expect(await hyperFrogs.maxMintPerTrans()).to.equal(5);
    expect(await hyperFrogs.maxMintPerWallet()).to.equal(5);
    expect(await hyperFrogs.maxMintOnWhitelist()).to.equal(2);
    expect(await hyperFrogs.maxOneOfOne()).to.equal(2);
    expect(await hyperFrogs.mintedOneOfOne()).to.equal(0);
  });

  it("Should set the whitelist mint time to be 6 hours from block time", async () => {
    // Define 6 hours in seconds.
    const sixHours = 6 * 60 * 60; // 21600 seconds
  
    const tx = await hyperFrogs.setWhitelistDuration(sixHours);
    const receipt = await tx.wait();
  
    const block = await ethers.provider.getBlock(receipt.blockNumber);
    const expectedWhitelistEndTime = block.timestamp + sixHours;
  
    const actualWhitelistEndTime = await hyperFrogs.whitelistEndTime();
    
    // Assert that the whitelistEndTime is equal to the expected value.
    expect(actualWhitelistEndTime).to.equal(expectedWhitelistEndTime);
  });

  it("Should revert mint if minting is not enabled", async () => {
    await expect(
      hyperFrogs.connect(addr1).mint(1, { value: ethers.parseEther("1.0") })
    ).to.be.revertedWithCustomError(hyperFrogs, "MintNotActive")
  });

  it("Should allow minting when enabled", async () => {
    // Enable minting.
    await hyperFrogs.toggleMinting();
    await hyperFrogs.connect(addr1).mint(1, { value: ethers.parseEther("1.0") });
    expect(await hyperFrogs.totalSupply()).to.equal(1);
  });

  it("Should revert mint if incorrect ETH is sent", async () => {
    await hyperFrogs.toggleMinting();
    await expect(
      hyperFrogs.connect(addr1).mint(1, { value: ethers.parseEther("0.5") })
    ).to.be.revertedWithCustomError(hyperFrogs, "IncorrectEthSent")
  });

  it("Should allow free minting for freelisted addresses", async () => {
    // Grant free mint rights by freelisting addr1.
    // Note: the function is protected by CONTROLLER_ROLE. Since deployer has that role, we call it from deployer.
    await hyperFrogs.addToFreeList([addr1.address]);
    // Enable free minting.
    await hyperFrogs.toggleFreeMinting();
    await hyperFrogs.connect(addr1).free_mint();
    expect(await hyperFrogs.totalSupply()).to.equal(1);
  });

  it("Should enforce whitelist minting rules, mint limits, and public mint access", async () => {
    const [deployer, addr1, addr2] = await ethers.getSigners();
    const sixHours = 6 * 60 * 60; // 6 hours in seconds
  
    // Set whitelist duration to 6 hours
    await hyperFrogs.setWhitelistDuration(sixHours);
  
    // Add addr1 to the whitelist
    await hyperFrogs.addToWhitelist([addr1.address]);
  
    // Enable minting
    await hyperFrogs.toggleMinting();
  
    // ========== WHITELIST PHASE ==========
    // ✅ addr1 should be able to mint during whitelist phase (up to 2 mints)
    await expect(
      hyperFrogs.connect(addr1).mint(1, { value: ethers.parseEther("1.0") })
    ).to.not.be.reverted;
  
    await expect(
      hyperFrogs.connect(addr1).mint(1, { value: ethers.parseEther("1.0") })
    ).to.not.be.reverted;
  
    // ❌ Third mint during whitelist should fail (exceeds limit)
    await expect(
      hyperFrogs.connect(addr1).mint(1, { value: ethers.parseEther("1.0") })
    ).to.be.revertedWithCustomError(hyperFrogs, "ExceedsMaxPerTx");
  
    // ✅ addr2 (not whitelisted) should NOT be able to mint during whitelist
    await expect(
      hyperFrogs.connect(addr2).mint(1, { value: ethers.parseEther("1.0") })
    ).to.be.revertedWithCustomError(hyperFrogs, "NotOnWhitelist");
  
    expect(await hyperFrogs.totalSupply()).to.equal(2); // Only addr1 minted 2
  
    // ========== FAST FORWARD TO PUBLIC MINT ==========
    await ethers.provider.send("evm_increaseTime", [sixHours + 1]);
    await ethers.provider.send("evm_mine");
  
    // ✅ addr2 can now mint in public phase (up to 5 mints)
    await expect(
      hyperFrogs.connect(addr2).mint(5, { value: ethers.parseEther("5.0") })
    ).to.not.be.reverted;
  
    // ❌ addr2 cannot mint more than 5 in public phase
    await expect(
      hyperFrogs.connect(addr2).mint(1, { value: ethers.parseEther("1.0") })
    ).to.be.revertedWithCustomError(hyperFrogs, "ExceedsMaxPerTx");
  
    // ✅ addr1 can still mint in public phase (up to 5 total, including previous mints)
    await expect(
      hyperFrogs.connect(addr1).mint(3, { value: ethers.parseEther("3.0") })
    ).to.not.be.reverted;
  
    // ❌ addr1 cannot mint more than 5 total in public phase
    await expect(
      hyperFrogs.connect(addr1).mint(1, { value: ethers.parseEther("1.0") })
    ).to.be.revertedWithCustomError(hyperFrogs, "ExceedsMaxPerTx");
  
    // ✅ Verify total supply is correct
    expect(await hyperFrogs.totalSupply()).to.equal(10); // 2 (addr1 in whitelist) + 5 (addr2) + 3 (addr1 in public)
  });  
  
  it("Should revert free mint if caller is not whitelisted", async () => {
    await hyperFrogs.toggleFreeMinting();
    await expect(hyperFrogs.connect(addr1).free_mint()).to.be.revertedWithCustomError(hyperFrogs, "NotOnWhitelist")
  });

  it("Should generate a valid tokenURI after mint", async () => {
    await hyperFrogs.toggleMinting();
    await hyperFrogs.connect(addr1).mint(1, { value: ethers.parseEther("1.0") });
    const tokenUri = await hyperFrogs.tokenURI(1);
    expect(tokenUri).to.include("data:application/json;base64,");
  });

  it("Should output previews for one oneOfOne token and one normal token from the batch", async () => {
    const batchSize = 100;
    await hyperFrogs.devMint(batchSize);
  
    let oneOfOneTokenId = 0;
    let normalTokenId = 0;
    
    // Iterate over minted tokens (IDs assumed to start at 1)
    for (let tokenId = 1; tokenId <= batchSize; tokenId++) {
      const traits = await hyperFrogs.tokenTraits(tokenId);
      if (traits.oneOfOne && oneOfOneTokenId === 0) {
        oneOfOneTokenId = tokenId;
      }
      if (!traits.oneOfOne && normalTokenId === 0) {
        normalTokenId = tokenId;
      }
      if (oneOfOneTokenId !== 0 && normalTokenId !== 0) break;
    }
    
    const fs = require("node:fs");
  
    if (oneOfOneTokenId !== 0) {
      const svgOne = await hyperFrogs.buildSVG(oneOfOneTokenId);
      const tokenUriOne = await hyperFrogs.tokenURI(oneOfOneTokenId);
      const base64JSONOne = tokenUriOne.split("base64,")[1];
      const metadataJsonOne = Buffer.from(base64JSONOne, "base64").toString("ascii");
      
      fs.writeFileSync("./test/previews/preview-1of1.svg", svgOne);
      fs.writeFileSync("./test/previews/metadata-1of1.json", metadataJsonOne);
    } else {
      console.log("No one-of-one token minted in this batch. Increase batch size or adjust probability for testing.");
    }
    
    if (normalTokenId !== 0) {
      const svgNormal = await hyperFrogs.buildSVG(normalTokenId);
      const tokenUriNormal = await hyperFrogs.tokenURI(normalTokenId);
      const base64JSONNormal = tokenUriNormal.split("base64,")[1];
      const metadataJsonNormal = Buffer.from(base64JSONNormal, "base64").toString("ascii");
      
      fs.writeFileSync("./test/previews/preview-normal.svg", svgNormal);
      fs.writeFileSync("./test/previews/metadata-normal.json", metadataJsonNormal);
    } else {
      console.log("No normal token found in this batch.");
    }
  
    // Basic sanity assertions.
    if (normalTokenId !== 0) {
      expect((await hyperFrogs.buildSVG(normalTokenId))).to.include("<svg");
    }
    if (oneOfOneTokenId !== 0) {
      expect((await hyperFrogs.buildSVG(oneOfOneTokenId))).to.include("<svg");
    }
  });

  it("Should output a horizontal table of trait distributions using console.table", async () => {
    const totalMinted = 100;
    await hyperFrogs.devMint(totalMinted);
  
    // Aggregate occurrences for each trait category.
    const distribution = {
      backdrop: {},
      hat: {},
      body: {},
      mouth: {},
      feet: {},
      eyesA: {},
      eyesB: {}
    };
  
    // Loop over each minted token (assuming token IDs start at 1)
    for (let tokenId = 1; tokenId <= totalMinted; tokenId++) {
      const traits = await hyperFrogs.tokenTraits(tokenId);
      const backdrop = traits.backdrop.toString();
      const hat = traits.hat.toString();
      const body = traits.body.toString();
      const mouth = traits.mouth.toString();
      const feet = traits.feet.toString();
      const eyesIndex = traits.eyesIndex.toString();
      const eyesIsA = traits.eyesIsA; // boolean
  
      distribution.backdrop[backdrop] = (distribution.backdrop[backdrop] || 0) + 1;
      distribution.hat[hat] = (distribution.hat[hat] || 0) + 1;
      distribution.body[body] = (distribution.body[body] || 0) + 1;
      distribution.mouth[mouth] = (distribution.mouth[mouth] || 0) + 1;
      distribution.feet[feet] = (distribution.feet[feet] || 0) + 1;
      if (eyesIsA) {
        distribution.eyesA[eyesIndex] = (distribution.eyesA[eyesIndex] || 0) + 1;
      } else {
        distribution.eyesB[eyesIndex] = (distribution.eyesB[eyesIndex] || 0) + 1;
      }
    }
  
    // Helper function: Given a category key and a lookup function,
    // return an array of objects for console.table.
    const createTable = async (categoryKey, getTraitNameFn) => {
      const tableData = [];
      for (const [traitIndex, count] of Object.entries(distribution[categoryKey])) {
        const traitName = await getTraitNameFn(traitIndex);
        const percentage = ((count / totalMinted) * 100).toFixed(2);
        tableData.push({ Trait: traitName, Count: count, Percentage: `${percentage}%` });
      }
      return tableData;
    };
  
    console.log("Trait Distribution Table:\n");
  
    console.log("Backdrop:");
    console.table(await createTable("backdrop", async (i) => await frogsBackdrop.getBackdropTrait(i)));
  
    console.log("Hat:");
    console.table(await createTable("hat", async (i) => await frogsHats.getHatsTrait(i)));
  
    console.log("Body:");
    console.table(await createTable("body", async (i) => await frogsBody.getBodyTrait(i)));
  
    console.log("Mouth:");
    console.table(await createTable("mouth", async (i) => await frogsMouth.getMouthTrait(i)));
  
    console.log("Feet:");
    console.table(await createTable("feet", async (i) => await frogsFeet.getFeetTrait(i)));
  
    console.log("EyesA:");
    console.table(await createTable("eyesA", async (i) => await frogsEyesA.getEyesATrait(i)));
  
    console.log("EyesB:");
    console.table(await createTable("eyesB", async (i) => await frogsEyesB.getEyesBTrait(i)));
  });
  
  
});
