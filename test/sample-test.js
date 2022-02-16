// const { expect } = require("chai");
// const { ethers } = require("hardhat");

// require("@openzeppelin/contracts/token/ERC20/ERC20.sol");

// describe("Greeter", function () {
//   it("Should return the new greeting once it's changed", async function () {
//     const Greeter = await ethers.getContractFactory("Greeter");
//     const greeter = await Greeter.deploy("Hello, world!");
//     await greeter.deployed();

//     expect(await greeter.greet()).to.equal("Hello, world!");

//     const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

//     // wait until the transaction is mined
//     await setGreetingTx.wait();

//     expect(await greeter.greet()).to.equal("Hola, mundo!");
//   });
// });

// describe("TreasuryMILv4", function () {
//   it("should return true", async function () {
    

//     const [owner] = await ethers.getSigners();
    
//     const TreasuryMILv4 = await ethers.getContractFactory("TreasuryMILv4");
//     const treasuryMILv4 = await TreasuryMILv4.deploy();

//     await treasuryMILv4.deployed();

//     erc20Token = ERC20Token.attach(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa);

//     erc20Token.approve()

//     expect(await treasuryMILv4.deposit("0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa", 12, 10, 100)).to.equal(true);
//   });
// });








// // describe("TreasuryMILv4", () => {
// //     const ALLOWANCE_AMOUNT = 100;
// //     const AMOUNT_TO_TRANSFER = 100;
// //     let owner, spender, holder;
// //     beforeEach(async () => {
// //         [owner, spender, holder] = await ethers.getSigners();
// //     });
// // it('Should allow spender contract get tokens from an holder account inside allowance limit', async () => {
        
// //         const TreasuryMILv4 = await ethers.getContractFactory("TreasuryMILv4");
// //         const treasuryMILv4 = await TreasuryMILv4.deploy();
// //       await treasuryMILv4.deployed();

// //         await this.contractToken.mint(holder.address, AMOUNT_TO_TRANSFER);
// //         await this.contractToken.connect(holder.address).approve(spender.address, ALLOWANCE_AMOUNT);
// // // supressed lines ...
// // });
// // }

