const fs = require("fs");
const path = require("path");

async function exportABI() {
  const skillTokenArtifact = require("../artifacts/contracts/SkillToken.sol/SkillToken.json");
  const skillEscrowArtifact = require("../artifacts/contracts/SkillEscrow.sol/SkillEscrow.json");
  const skillBadgeArtifact = require("../artifacts/contracts/SkillBadgeNFT.sol/SkillBadgeNFT.json");
  const skillProfileArtifact = require("../artifacts/contracts/SkillProfile.sol/SkillProfile.json");

  const addresses = {
    SkillToken: "0xFADb4f13717aD3A8559c87C34EC00BaE9Ad09b0b",
    SkillEscrow: "0x7fdc64f2c01665a8BBadd3ff38d71945dBeAddd1",
    SkillBadgeNFT: "0x99c825B019cf0c5130381e7cc76566CeCd1F29d8",
    SkillProfile: "0x815F053D19bba32ec15aF1d076216E5544DCf2fE",
  };

  const outputDir = path.join(__dirname, "..", "frontend-exports");

  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }

  fs.writeFileSync(
    path.join(outputDir, "abis.json"),
    JSON.stringify(
      {
        SkillToken: skillTokenArtifact.abi,
        SkillEscrow: skillEscrowArtifact.abi,
        SkillBadgeNFT: skillBadgeArtifact.abi,
        SkillProfile: skillProfileArtifact.abi,
      },
      null,
      2
    )
  );

  fs.writeFileSync(
    path.join(outputDir, "addresses.json"),
    JSON.stringify(addresses, null, 2)
  );

  console.log("✅ ABI and addresses exported to frontend-exports/");
}

exportABI();
