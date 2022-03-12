const { NFTStorage, File }= require("nft.storage"); // https://yarnpkg.com/package/nft.storage
const fs = require("fs"); 
require('dotenv').config();
const {NFT_STORAGE_API_KEY} = process.env 

// example: https://nftschool.dev/tutorial/mint-nftstorage-polygon/#minting-your-nft 

async function storeAsset() {
   const client = new NFTStorage({ token: NFT_STORAGE_API_KEY })
   const metadata = await client.store({
       name: 'ExampleNFT',
       description: 'My ExampleNFT is an awesome artwork!',
       image: new File(
           [await fs.promises.readFile('images/20210918_SQ_UK.jpg')],
           '20210918_SQ_UK.jpg',
           { type: 'image/jpg' }
       ),
   })
   console.log("Metadata stored on Filecoin and IPFS with URL:", metadata.url)
} // npx hardhat run scripts/store-assets1155.js

storeAsset()
   .then(() => process.exit(0))
   .catch((error) => {
       console.error(error);
       process.exit(1);
   });