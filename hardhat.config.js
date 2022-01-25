require("@nomiclabs/hardhat-waffle");
require('dotenv').config()

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

module.exports = {
  solidity: "0.8.4",
  paths: {
    artifacts: './src/artifacts'
  },
  networks: {
    hardhat: {
      chainId: 1337
    },
    kovan: {
      url: "https://kovan.infura.io/v3/5d26be1b7763445f9cc969b6a8102b5c",
      accounts: [`0x${process.env.ACCOUNT_PRIVATE_KEY}`]
    }
  }
};
