const hre = require("hardhat");

const globalInboxAddress = "0xE681857DEfE8b454244e701BA63EfAa078d7eA85"
const rollupChainAddress = "0xC34Fd04E698dB75f8381BFA7298e8Ae379bFDA71"

async function main() {
  // We get the contract to deploy
  const EthERC20 = await hre.ethers.getContractFactory("EthERC20")
  const erc20 = await EthERC20.deploy(globalInboxAddress)
  await erc20.deployed()

  console.log("Token deployed to:", erc20.address)

  await erc20.connectToChain(rollupChainAddress)

  console.log("Deployed paired contract to L2 chain")
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error)
    process.exit(1)
  });
