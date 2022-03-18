const {ERC1155CONTRACT_ADDRESS, META_DATA_URL} = process.env 

// https://nft.storage/docs/how-to/mint-erc-1155/
// https://nft.storage/files/  
// пример sell.js https://github.com/ProjectOpenSea/opensea-erc1155/tree/master/scripts

async function mintNFT(ERC1155CONTRACT_ADDRESS, META_DATA_URL) {
   const NFT1155Token = await ethers.getContractFactory("NFT1155Token")
   const [owner] = await ethers.getSigners()
   const response = await NFT1155Token.attach(ERC1155CONTRACT_ADDRESS).mint(3, META_DATA_URL) 
   console.log("NFT minted to: ", owner.address)
   console.log(`Transaction Hash: ${response.hash}`)
}

mintNFT(ERC1155CONTRACT_ADDRESS, META_DATA_URL)
   .then(() => process.exit(0))
   .catch((error) => {
       console.error(error);
       process.exit(1);
   });

   // npx hardhat run scripts/mint1155.js --network rinkeby