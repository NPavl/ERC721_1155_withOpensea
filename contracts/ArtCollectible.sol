// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ArtCollectible is Ownable, ERC1155 {

    string private baseURI;
    string public name;
    constructor() 
        ERC1155(
            'ipfs://QmXWrffcWUw2f3Cx9mFx3zzQu7dzQiqsDfT5DKmjJG5HCN/{id}.json'
        )
    {
        setName('My amazing shit collection');
    }

    function setURI(string memory _newuri) public onlyOwner { 
        _setURI(_newuri);
    }

    function setName(string memory _name) public onlyOwner {
        name = _name;
    }

    function mintBatch(uint256[] memory ids, uint256[] memory amounts)
        public
        onlyOwner
    {
        _mintBatch(msg.sender, ids, amounts, '');
    }

    function mint(uint256 id, uint256 amount) public onlyOwner {
        _mint(msg.sender, id, amount, '');
    }
}