const { NFTStorage, File } = require("nft.storage"); 
const fs = require("fs");
require('dotenv').config();
const { NFT_STORAGE_API_KEY } = process.env

// тупой но рабочий скрипт. упаковывает image и metadata в один файл вида : 
// "ipfs://bafyreidnqqbn66jtcdaij2ugj6iigtadmj6wnka5hsu46geytyovspgxtu/metadata.json"
// загружает на NFTStorage и без проблем устанавл на opensea с атибутами. 

// example: https://nftschool.dev/tutorial/mint-nftstorage-polygon/#minting-your-nft 
// https://github.com/nftstorage
// https://github.com/nftstorage/nft.storage/tree/main/packages/client
// https://github.com/nftstorage/nft.storage/tree/main/packages/client/examples доп примеры

// npx hardhat run scripts/store-assets721_batch.js --network rinkeby
async function storeAsset() {

    const client = new NFTStorage({ token: NFT_STORAGE_API_KEY })
// 1
    const metadata = await client.store({
        name: 'Enter the Metaverse',
        description: 'My ExampleNFT6 is an awesome artwork!',
        image: new File(
            [await fs.promises.readFile('images2/6.png')],
            '6.png',
            { type: 'image/png' }
        ),
        external_url: "https://example.com/?token_id=6",
        attributes: [
            {
               "trait_type" : "level",
               "value" : 3
            },
            {
               "trait_type" : "stamina",
               "value" : 11.7
            },
            {
               "trait_type" : "personality",
               "value" : "sleepy"
            },
            {
               "display_type" : "boost_number",
               "trait_type" : "aqua_power",
               "value" : 30
            },
            {
               "display_type" : "boost_percentage",
               "trait_type" : "stamina_increase",
               "value" : 15
            },
            {
               "display_type" : "number",
               "trait_type" : "generation",
               "value" : 1
            }
         ],
    })
    console.log("Metadata stored on Filecoin and IPFS with URL:", metadata.url)
// 2
    const metadata1 = await client.store({
        name: 'Yellow crab killer',
        description: 'My ExampleNFT7 is an awesome artwork!',
        image: new File(
            [await fs.promises.readFile('images2/7.png')],
            '7.png',
            { type: 'image/png' }
        ),
        external_url: "https://example.com/?token_id=7",
        attributes: [
            {
               "trait_type" : "level",
               "value" : 3
            },
            {
               "trait_type" : "stamina",
               "value" : 11.7
            },
            {
               "trait_type" : "personality",
               "value" : "sleepy"
            },
            {
               "display_type" : "boost_number",
               "trait_type" : "aqua_power",
               "value" : 30
            },
            {
               "display_type" : "boost_percentage",
               "trait_type" : "stamina_increase",
               "value" : 15
            },
            {
               "display_type" : "number",
               "trait_type" : "generation",
               "value" : 1
            }
         ],
    })
    console.log("Metadata stored on Filecoin and IPFS with URL:", metadata1.url)
// 3
    const metadata3 = await client.store({
        name: 'Metaverse builder',
        description: 'My ExampleNFT8 is an awesome artwork!',
        image: new File(
            [await fs.promises.readFile('images2/8.png')],
            '8.png',
            { type: 'image/png' }
        ),
        external_url: "https://example.com/?token_id=8",
        attributes: [
            {
               "trait_type" : "level",
               "value" : 3
            },
            {
               "trait_type" : "stamina",
               "value" : 11.7
            },
            {
               "trait_type" : "personality",
               "value" : "sleepy"
            },
            {
               "display_type" : "boost_number",
               "trait_type" : "aqua_power",
               "value" : 30
            },
            {
               "display_type" : "boost_percentage",
               "trait_type" : "stamina_increase",
               "value" : 15
            },
            {
               "display_type" : "number",
               "trait_type" : "generation",
               "value" : 1
            }
         ],
    })
    console.log("Metadata stored on Filecoin and IPFS with URL:", metadata3.url)
// 4
    const metadata4 = await client.store({
        name: 'Ethereum logo',
        description: 'My ExampleNFT9 is an awesome artwork!',
        image: new File(
            [await fs.promises.readFile('images2/9.png')],
            '9.png',
            { type: 'image/png' }
        ),
        external_url: "https://example.com/?token_id=9",
        attributes: [
            {
               "trait_type" : "level",
               "value" : 3
            },
            {
               "trait_type" : "stamina",
               "value" : 11.7
            },
            {
               "trait_type" : "personality",
               "value" : "sleepy"
            },
            {
               "display_type" : "boost_number",
               "trait_type" : "aqua_power",
               "value" : 30
            },
            {
               "display_type" : "boost_percentage",
               "trait_type" : "stamina_increase",
               "value" : 15
            },
            {
               "display_type" : "number",
               "trait_type" : "generation",
               "value" : 1
            }
         ],
    })
    console.log("Metadata stored on Filecoin and IPFS with URL:", metadata4.url)

// 5
    const metadata5 = await client.store({
        name: 'Still 1 logo ethereum',
        description: 'My ExampleNFT10 is an awesome artwork!',
        image: new File(
            [await fs.promises.readFile('images2/10.png')],
            '10.png',
            { type: 'image/png' }
        ),
        external_url: "https://example.com/?token_id=10",
        attributes: [
            {
               "trait_type" : "level",
               "value" : 3
            },
            {
               "trait_type" : "stamina",
               "value" : 11.7
            },
            {
               "trait_type" : "personality",
               "value" : "sleepy"
            },
            {
               "display_type" : "boost_number",
               "trait_type" : "aqua_power",
               "value" : 30
            },
            {
               "display_type" : "boost_percentage",
               "trait_type" : "stamina_increase",
               "value" : 15
            },
            {
               "display_type" : "number",
               "trait_type" : "generation",
               "value" : 1
            }
         ],
    })
    console.log("Metadata stored on Filecoin and IPFS with URL:", metadata5.url)
} // npx hardhat run scripts/store-assets721_batch.js --network rinkeby

storeAsset()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });