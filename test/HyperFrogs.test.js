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

    // Optionally, check that each trait contract has a valid address.
    expect(frogsBody.target).to.properAddress;
    expect(frogsHats.target).to.properAddress;
    expect(frogsEyesA.target).to.properAddress;
    expect(frogsEyesB.target).to.properAddress;
    expect(frogsMouth.target).to.properAddress;
    expect(frogsFeet.target).to.properAddress;
    expect(frogsBackdrop.target).to.properAddress;

    // Deploy HyperFrogs with the addresses of the trait contracts.
    HyperFrogs = await ethers.getContractFactory("HyperFrogs");
    hyperFrogs = await HyperFrogs.deploy(
      frogsBody.target,
      frogsHats.target,
      frogsEyesA.target,
      frogsEyesB.target,
      frogsMouth.target,
      frogsFeet.target,
      frogsBackdrop.target
    );
    await hyperFrogs.waitForDeployment();
  });

  it("Should deploy with correct initial values", async () => {
    expect(await hyperFrogs.maxSupply()).to.equal(2222);
    expect(await hyperFrogs.mintPrice()).to.equal(ethers.parseEther("1.0"));
    expect(await hyperFrogs.maxMintPerTrans()).to.equal(5);
    expect(await hyperFrogs.maxMintPerWallet()).to.equal(10);
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

  it("Should allow free minting for whitelisted addresses", async () => {
    // Grant free mint rights by whitelisting addr1.
    // Note: the function is protected by CONTROLLER_ROLE. Since deployer has that role, we call it from deployer.
    await hyperFrogs.addToWhiteList([addr1.address]);
    // Enable free minting.
    await hyperFrogs.toggleFreeMinting();
    await hyperFrogs.connect(addr1).free_mint();
    expect(await hyperFrogs.totalSupply()).to.equal(1);
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

  it("Should return a valid SVG for a minted token", async () => {
    // Enable minting and mint a token.
    await hyperFrogs.toggleMinting();
    await hyperFrogs.connect(addr1).mint(1, { value: ethers.parseEther("1.0") });
    
    // Retrieve the SVG.
    const svg = await hyperFrogs.buildSVG(1);
    
    // Check that it contains typical SVG tags.
    expect(svg).to.be.a('string');
    expect(svg).to.include("<svg");
    expect(svg).to.include("</svg>");

    // Log the SVG to the console.
    console.log("SVG for token 1:", svg);

    // Optionally, write the SVG to a file so you can view it in a browser.
    const fs = require("node:fs");
    fs.writeFileSync("token1.svg", svg);
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
