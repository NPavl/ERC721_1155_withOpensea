# Basic Sample Hardhat Project

#### Deploy
Token eRC721NFTOne contract address: 0xF8B470Fd503F9A213fde5E759e04AeB070a8DFaD
https://rinkeby.etherscan.io/address/0xF8B470Fd503F9A213fde5E759e04AeB070a8DFaD#code
--
Token eRC1155 contract address: 0x4eD4c984c432B231f4C564A6A113Ab18Cca0Fa38
https://rinkeby.etherscan.io/address/0x4eD4c984c432B231f4C564A6A113Ab18Cca0Fa38#code
--
#### IPFS
https://ipfs.io/ipfs/bafybeige25bvp6z4p5orv72v26fbhmforboelbtwdasdbfh7jop57efilq/images

Metadata URL: 
https://bafybeih35vq7wb53pp2wewuedqs3pckahkcpx5zzco2impuuuoqyl4u2qy.ipfs.dweb.link/metadata/1

https://testnets.opensea.io/get-listed/   

OpenSea Developer Documentation (https://docs.opensea.io/docs/metadata-standards)
https://docs.opensea.io/docs/metadata-standards

IPFS Documentation | IPFS Docs
https://docs.ipfs.io/

#### Задание 
```
- Написать контракты NFT стандартов ERC-721, ERC-1155 совместимые с opensea. Можно наследовать паттерн у openzeppelin. 
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
yarn add --dev node-fetch
yarn add install dotenv 
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
npx hardhat verify --constructor-args scripts/arguments.js <contract_address> --network rinkeby
npx hardhat verify --constructor-args scripts/arguments.js 0xfd934275FBB3dDF0D023E4623497E7aB4e2B74E7 --network rinkeby
npx hardhat mintERC721NFTBase --address 0xaF3f0ba2848093D6eEaF4109bfD9A9FbbBA1f470  (owner address) 
yarn run hardhat size-contracts 
yarn run hardhat size-contracts --no-compile

> images, metadata:
npx ipfs-car --pack images --output images.car
npx ipfs-car --pack metadata --output metadata.car

npx hardhat set-base-token-uri --base-url "https://bafybeih35vq7wb53pp2wewuedqs3pckahkcpx5zzco2impuuuoqyl4u2qy.ipfs.dweb.link/metadata/"
```
#### IPFS инструкция:
https://docs.opensea.io/docs/part-3-adding-metadata-and-payments-to-your-contract
https://nft.storage/
```
npx ipfs-car --pack images --output images.car
npx ipfs-car --pack metadata --output metadata.car


```