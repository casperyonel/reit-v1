const hre = require("hardhat");

async function main() {
  // const Greeter = await hre.ethers.getContractFactory("Greeter");
  // const greeter = await Greeter.deploy("Hello, Hardhat!");
  // await greeter.deployed();
  // console.log("Greeter deployed to:", greeter.address);

  // const PreSale = await hre.ethers.getContractFactory("PreSale");
  // const presale = await PreSale.deploy('0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa'); // DAI Address
  // await presale.deployed();
  // console.log('PreSale contract deployed to: ', presale.address);
 
  const PreSaleKovan = await hre.ethers.getContractFactory("PreSaleKovan");
  const presalekovan = await PreSaleKovan.deploy();
  await presalekovan.deployed();
  console.log('PreSaleKovan contract deployed to: ', presalekovan.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
