require('dotenv').config()
require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();
  for (const account of accounts) {
  	const balance = await ethers.provider.getBalance(account.address)
    console.log(`${account.address}: ${balance}`)
  }
});

task("name", "Prints the list of accounts")
.addPositionalParam("address", "The address of the token contract")
.setAction(async (taskArguments) => {
  const ierc20 = await ethers.getContractAt("ERC20", taskArguments.address)
  console.log(await ierc20.name())
});

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.7.3",
  networks: {
  	hardhat: {},
  	kovan: {
      url: `https://kovan.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: [process.env.KOVAN_PRIVATE_KEY]
    },
  	arbitrum: {
  		url: "https://kovan2.arbitrum.io/rpc",
      	accounts: [process.env.KOVAN_PRIVATE_KEY]
  	}
  }
};

