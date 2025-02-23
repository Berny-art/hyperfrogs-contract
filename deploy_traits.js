const HyperFrogs = await ethers.getContractFactory("HyperFrogs");
const hyperFrogs = await HyperFrogs.deploy(
    frogsBody.address,
    frogsHats.address,
    frogsEyes.address,
    frogsMouth.address,
    frogsFeet.address,
    frogsBackdrop.address
);
await hyperFrogs.deployed();
console.log("HyperFrogs deployed to:", hyperFrogs.address);