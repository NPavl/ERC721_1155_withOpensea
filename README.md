## Basic Sample Hardhat Project
#### Deploy

https://testnets.opensea.io/get-listed/  

##### Un f.cking believable collection (first steps):
Token ERC721NFTBase2 contract address: 0x59DB46a4a8853163B372117B13B8591ddd4403A9
- https://rinkeby.etherscan.io/address/0x59DB46a4a8853163B372117B13B8591ddd4403A9
- https://testnets.opensea.io/collection/nftcontract-apwctwsv5p

- Token ERC1155 Base "ArtCollectible" contract address: 0x5Ee7C42337559EdC07E8B6768C097dEa6aA81034
- https://rinkeby.etherscan.io/address/0x5Ee7C42337559EdC07E8B6768C097dEa6aA81034#readContract
- https://testnets.opensea.io/collection/my-amazing-shit-collection
  deployer: 0x0B642b7bD0ac3D4cACc92877c1Ed4B433Ecfd86c

- Token ERC1155GameItems contract address: 0xa6f6724f3AEf1A17a134d4C62faF00E2A953fb0B
- https://rinkeby.etherscan.io/address/0xa6f6724f3AEf1A17a134d4C62faF00E2A953fb0B#code
- по ошибке удалил с пинаты image. завис основной кошель который owner этого контракта. 

Token eRC1155 contract address: 0x4eD4c984c432B231f4C564A6A113Ab18Cca0Fa38
- https://rinkeby.etherscan.io/address/0x4eD4c984c432B231f4C564A6A113Ab18Cca0Fa38#code
- Opensea не видит контракт (не соответствует стандарту ERC1155) 

#### Storages
https://app.pinata.cloud/pinmanager
https://nft.storage/files/
https://docs.ipfs.io/
https://car.ipfs.io/ 

OpenSea Developer Documentation 
https://docs.opensea.io/docs/metadata-standards
https://docs.opensea.io/docs/4-debugging-your-metadata

#### Задание 
```
- Написать контракты NFT стандартов ERC-721, ERC-1155 совместимые с opensea. Можно наследовать паттерн у   openzeppelin. 
- Написать контракт NFT
- Написать полноценные тесты к контракту
- Написать скрипт деплоя
- Задеплоить в тестовую сеть
- Написать таск на mint
- Верифицировать контракт
- Загрузить какой либо файл на ipfs
- Вставить в контракт NFT ссылку на ipfs

Требования
- Все предусмотренные стандартами ERC-721, ERC-1155 функции
- Все данные NFT должны отображаться на opensea
```
#### All packages:
```
yarn init 
yarn add --dev hardhat 
yarn add --dev @nomiclabs/hardhat-ethers ethers 
yarn add --dev @nomiclabs/hardhat-waffle ethereum-waffle chai
yarn add --save-dev @nomiclabs/hardhat-etherscan
yarn add --dev node-fetch (это говно не работает юзай axios)
yarn add --dev axios
yarn add --dev nft.storage 
yarn add --dev opensea
yarn add --dev dotenv 
yarn add --dev solidity-coverage
yarn add --dev hardhat-gas-reporter 
yarn add --dev hardhat-gas-reporter
yarn add --dev hardhat-contract-sizer
```
#### Main command:
```
npx hardhat 
npx hardhat compile
npx hardhat run scripts/file-name.js
npx hardhat test 
npx hardhat coverage
npx hardhat run --network localhost scripts/deploy.js 
npx hardhat run scripts/deploy.js --network rinkeby
npx hardhat verify <contract_address> --network rinkeby
npx hardhat verify --constructor-args scripts/arguments.js <contract_address> --network rinkeby
npx hardhat mintERC721NFTBase --address <contract_address>  
yarn run hardhat size-contracts 
yarn run hardhat size-contracts --no-compile
npx hardhat run scripts/file.js
npx hardhat run scripts/file.js --network rinkeby

```
#### IPFS:
```
npx ipfs-car --pack images --output images.car  
npx ipfs-car --pack metadata --output metadata.car
npx hardhat set-base-token-uri --base-url "https://bafybeicq4syucu6alfwwgomiprevdcmo6r4jk5bafgisezzl6tt7s46ipy.ipfs.dweb.link/metadata/"

baseIpfsUriForever: 
contract: 'ipfs://QmXWrffcWUw2f3Cx9mFx3zzQu7dzQiqsDfT5DKmjJG5HCN/{id}.json'
"image" : "ipfs://QmW6CkdzGEKMRe1P3j3JBSxF7mx35naEcnnyzy3WhGXLBz/2.png"
```