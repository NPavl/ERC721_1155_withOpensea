// const { task } = require("hardhat/config");
// const { getAccount } = require("./helpers");

async function main() {

  const [deployer] = await ethers.getSigners()

  console.log("Deploying contracts with the account:", deployer.address)

  console.log("Account balance:", (await deployer.getBalance()).toString())

  const ERC721NFTOne = await ethers.getContractFactory("ERC721NFTBase")
  const eRC721NFTOne = await ERC721NFTOne.deploy()

  const ERC1155 = await ethers.getContractFactory("NFT1155Token")
  const eRC1155 = await ERC1155.deploy()

  const ERC721NFTBase2 = await ethers.getContractFactory("ERC721NFTBase2")
  const eRC721NFTBase2 = await ERC721NFTBase2.deploy()

  console.log("Account balance:", (await deployer.getBalance()).toString())

  console.log("Token eRC721NFTOne contract address:", eRC721NFTOne.address)
  console.log("Token eRC1155 contract address:", eRC1155.address)

  console.log("Token ERC721NFTBase2 contract address:", eRC721NFTBase2.address)
  console.log(`Token ERC721NFTBase2 contract hash:, ${eRC721NFTBase2.hash}`)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })


// task("check-balance", "Prints out the balance of your account").setAction(async function (taskArguments, hre) {
//     const account = getAccount();
//     console.log(`Account balance for ${account.address}: ${await account.getBalance()}`);
// });

// task("deploy", "Deploys the ERC721NFTBase.sol contract").setAction(async function (taskArguments, hre) {
//     const nft721ContractFactory = await hre.ethers.getContractFactory("ERC721NFTBase", getAccount());
//     const nft = await nft721ContractFactory.deploy();
//     console.log(`Contract deployed to address: ${nft.address}`);
// });

// task("deploy", "Deploys the NFT1155Token.sol contract").setAction(async function (taskArguments, hre) {
//   const nf1155ContractFactory = await hre.ethers.getContractFactory("NFT1155Token", getAccount());
//   const nft = await nf1155ContractFactory.deploy();
//   console.log(`Contract deployed to address: ${nft.address}`);
// });
