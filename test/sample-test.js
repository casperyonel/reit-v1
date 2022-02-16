const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();

    expect(await greeter.greet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});

describe("TreasuryMILv4", function () {
  it("should return true", async function () {
    const TreasuryMILv4 = await ethers.getContractFactory("TreasuryMILv4");
    const treasuryMILv4 = await TreasuryMILv4.deploy();
    await treasuryMILv4.deployed();

    expect(await treasuryMILv4.deposit(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa, 12, 10, 100)).to.equal(true);
  });
});

