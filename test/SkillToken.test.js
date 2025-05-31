const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SkillToken", function () {
  let token, owner, user1, user2;

  beforeEach(async function () {
    const SkillToken = await ethers.getContractFactory("SkillToken");
    [owner, user1, user2] = await ethers.getSigners();
    token = await SkillToken.deploy();
    await token.waitForDeployment();
  });

  it("should assign initial supply to the owner", async function () {
    const ownerBalance = await token.balanceOf(owner.address);
    expect(ownerBalance).to.be.gt(0);
  });

  it("should allow faucet to send tokens", async function () {
    await token.connect(user1).faucet();
    const balance = await token.balanceOf(user1.address);
    expect(balance).to.equal(ethers.parseEther("100"));
  });

  it("should not allow double faucet", async function () {
    await token.connect(user1).faucet();
    await expect(token.connect(user1).faucet()).to.be.revertedWith(
      "Faucet already used"
    );
  });

  it("should allow owner to mint tokens", async function () {
    await token.connect(owner).mint(user1.address, ethers.parseEther("50"));
    const balance = await token.balanceOf(user1.address);
    expect(balance).to.equal(ethers.parseEther("50"));
  });

  it("should not allow non-owner to mint", async function () {
    await expect(
      token.connect(user1).mint(user2.address, 10)
    ).to.be.revertedWithCustomError(token, "OwnableUnauthorizedAccount");
  });
});
