
// ОСНОВНОЙ СКРИПТ MINT для ERC721NFTBase перенес в hardahat.config.js : 
// task("mintERC721NFTBase", "Mints from the NFT contract")
// task("mintNFT1155Token", "Mints from the NFT contract")
// ЗДЕСЬ ДОП РЕАЛЬЗАЦИЯ 

const { ERC721CONTRACT2_ADDRESS, META_DATA_URL1, META_DATA_URL2} = process.env

// https://nft.storage/docs/how-to/mint-erc-1155/
// https://nft.storage/files/  

async function mintNFT() {
   const ERC721NFTBase = await ethers.getContractFactory("ERC721NFTBase2")
   const [owner] = await ethers.getSigners()
   console.log("NFT minted to: ", owner.address)
   //---
   const response = await ERC721NFTBase.attach(ERC721CONTRACT2_ADDRESS)
      .safeMint(owner.address, META_DATA_URL1, {
         value: ethers.utils.parseEther('0.001'),
         gasLimit: 500_000
      })
   console.log(`Transaction Hash: ${response.hash}`)
   //---

   const response2 = await ERC721NFTBase.attach(ERC721CONTRACT2_ADDRESS)
      .safeMint(owner.address, META_DATA_URL2, {
         value: ethers.utils.parseEther('0.001'),
         gasLimit: 500_000
      })
   // const response = await ERC721NFTBase.connect(owner.address).mintTo(owner.address) 
   console.log(`Transaction Hash: ${response2.hash}`)
}

mintNFT()
   .then(() => process.exit(0))
   .catch((error) => {
      console.error(error);
      process.exit(1);
   });

   // npx hardhat run scripts/mint1155.js --network rinkeby