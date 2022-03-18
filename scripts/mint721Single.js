
// Доп СКРИПТ 
// MINT для ERC721NFTBase перенес в hardahat.config.js : 
// task("mintERC721NFTBase", "Mints from the NFT contract")
// task("mintNFT1155Token", "Mints from the NFT contract")

// ERC721NFTBase Mint и привязка к IPFS json файлу 
const { ERC721CONTRACT2_ADDRESS, META_DATA_URL1} = process.env

// https://nft.storage/docs/how-to/mint-erc-1155/
// https://nft.storage/files/  

async function mintNFT(ERC721CONTRACT2_ADDRESS, META_DATA_URL1) {
   const ERC721NFTBase = await ethers.getContractFactory("ERC721NFTBase2")
   const [owner] = await ethers.getSigners()
   const response = await ERC721NFTBase.attach(ERC721CONTRACT2_ADDRESS)
      .safeMint(owner.address, META_DATA_URL1, {
         value: ethers.utils.parseEther('0.001'),
         gasLimit: 500_000
      }) 
   // const response = await ERC721NFTBase.connect(owner.address).mintTo(owner.address) 
   console.log("NFT minted to: ", owner.address)
   console.log(`Transaction Hash: ${response.hash}`)
}
   
mintNFT(ERC721CONTRACT2_ADDRESS, META_DATA_URL1)
   .then(() => process.exit(0))
   .catch((error) => {
      console.error(error);
      process.exit(1);
   });

   // npx hardhat run scripts/mint1155.js --network rinkeby