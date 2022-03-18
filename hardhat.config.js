  require("@nomiclabs/hardhat-waffle")
  require("@nomiclabs/hardhat-ethers")
  require("@nomiclabs/hardhat-etherscan")
  const { getAccount, getContract } = require("./scripts/helpers")
  require('dotenv').config()
  // const fetch = require("node-fetch");
  const axios = require('axios').default;
  const {PRIVATE_KEY, PRIVATE_KEY2, ALCHEMY_API_KEY, ETHERSCAN_API_KEY, COINMARKETCAP_API_KEY} = process.env
  // require('solidity-coverage')
  // require("hardhat-gas-reporter")
  // require('hardhat-contract-sizer')

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await ethers.getSigners()
  
  for (const account of accounts) {
    console.log("Account.address: ", account.address)
  }
  console.log("Account balance:", (await deployer.getBalance()).toString())
})
// таски взяты отсюда https://docs.opensea.io/docs/minting-from-your-new-contract-and-improvements
// > npx hardhat check-balance
task("check-balance", "Prints out the balance of your account").setAction(async function (taskArguments, hre) {
    const account = getAccount()
    console.log(`Account balance for ${account.address}: ${await account.getBalance()}`)
})

// https://docs.opensea.io/docs/part-3-adding-metadata-and-payments-to-your-contract
// > npx hardhat set-base-token-uri --base-url "https://bafybeif6iuokmmcuwj7jgscybx3gvlcwkb6ybspwcduivl7mbqmgmmxubi.ipfs.dweb.link/metadata/"
task("set-base-token-uri", "Sets the base token URI for the deployed smart contract")
.addParam("baseUrl", "The base of the tokenURI endpoint to set")
.setAction(async function (taskArguments, hre) {
    const contract = await getContract("ERC1155GameItems", hre);
    const transactionResponse = await contract.setBaseTokenURI(taskArguments.baseUrl, {
        gasLimit: 500_000,
    })
    console.log(`Transaction Hash: ${transactionResponse.hash}`)
})

// > npx hardhat token-uri --token-id 1
// > npx hardhat token-uri --token-id 2 ...
// https://docs.opensea.io/docs/4-debugging-your-metadata
task("token-uri", "Fetches the token metadata for the given token ID")
.addParam("tokenId", "The tokenID to fetch metadata for")
.setAction(async function (taskArguments, hre) {
    const contract = await getContract("ERC1155GameItems", hre);
    const response = await contract.tokenURI(taskArguments.tokenId, {
        gasLimit: 500_000,
    })
    
    const metadata_url = response;
    console.log(`Metadata URL: ${metadata_url}`)

    const metadata = await axios.get(metadata_url).then(result => console.log('success:', result))
    .catch(error => console.log('error:', error))
    console.log(`Metadata fetch response: ${JSON.stringify(metadata, null, 2)}`)
})

// https://docs.opensea.io/docs/minting-from-your-new-contract-and-improvements
// > npx hardhat mint --address <contract_address>
task("mintERC721NFTBase", "Mints from the NFT contract")
.addParam("address", "The address to receive a token")
.setAction(async function (taskArguments, hre) {
    const contract = await getContract("ERC721NFTBase", hre)
    const transactionResponse = await contract.mintTo(taskArguments.address, {
        value: ethers.utils.parseEther('0.001'),
        gasLimit: 500_000 
    })
    console.log(`Transaction Hash: ${transactionResponse.hash}`)
})

task("mintNFT1155Token", "Mints from the NFT contract")
.addParam("address", "The address to receive a token")
.setAction(async function (taskArguments, hre) {
    const contract = await getContract("NFT1155Token", hre)
    const transactionResponse = await contract.mint(taskArguments.address, {
        gasLimit: 500_000,
    })
    console.log(`Transaction Hash: ${transactionResponse.hash}`)
})


  module.exports = {
    solidity: "0.8.4",
    networks: {
      // ethereum: {
      //   chainId: 1,
      //   url: `https://eth-mainnet.alchemyapi.io/v2/${ALCHEMY_KEY}`,
      //   accounts: [`0x${ACCOUNT_PRIVATE_KEY}`]
      // },
      rinkeby: {
        url: `https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
        accounts: [`${PRIVATE_KEY2}`], // [`0x${PRIVATE_KEY}`]
        network_id: 4
      },
      // ropsten: {
      //   url: `https://ropsten.infura.io/v3/${INFURA_API_KEY}`,
      //   accounts: [`0x${PRIVATE_KEY}`],
      //   network_id: 3
      // },
      // hardhat: {
      //   forking: {
      //     url: `https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}`
      //   }
      // },
      // bcs_test: {
      //   url: `https://mainnet.infura.io/v3/${ALCHEMY_API_KEY}`,
      //   accounts: [`0x${PRIVATE_KEY}`],
      //   network_id: 97
      // }
    },
    gasReporter: {
      currency: "USD",
      coinmarketcap: COINMARKETCAP_API_KEY || null, // process.env.COINMARKETCAP_API_KEY
    },
    // gasReporter: {
    //   enabled: process.env.REPORT_GAS ? true : false, 
    //   currency: "ETH",
    //   // gasPrice: 21, 
    //   coinmarketcap: COINMARKETCAP_API_KEY
    // },
    etherscan: {
      apiKey: ETHERSCAN_API_KEY
    }
  }
