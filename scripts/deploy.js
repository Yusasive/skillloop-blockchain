const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying contracts with:", deployer.address);

  const SkillToken = await hre.ethers.getContractFactory("SkillToken");
  const skillToken = await SkillToken.deploy();
  await skillToken.waitForDeployment();
  console.log("SkillToken deployed to:", await skillToken.getAddress());

  const SkillEscrow = await hre.ethers.getContractFactory("SkillEscrow");
  const skillEscrow = await SkillEscrow.deploy(await skillToken.getAddress());
  await skillEscrow.waitForDeployment();
  console.log("SkillEscrow deployed to:", await skillEscrow.getAddress());

  const SkillBadgeNFT = await hre.ethers.getContractFactory("SkillBadgeNFT");
  const skillBadge = await SkillBadgeNFT.deploy();
  await skillBadge.waitForDeployment();
  console.log("SkillBadgeNFT deployed to:", await skillBadge.getAddress());

  const SkillProfile = await hre.ethers.getContractFactory("SkillProfile");
  const skillProfile = await SkillProfile.deploy();
  await skillProfile.waitForDeployment();
  console.log("SkillProfile deployed to:", await skillProfile.getAddress());

  return {
    skillToken,
    skillEscrow,
    skillBadge,
    skillProfile,
  };
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
