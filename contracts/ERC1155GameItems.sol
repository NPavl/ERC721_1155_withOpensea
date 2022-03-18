// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
// import "@openzeppelin/contracts/security/PullPayment.sol";

contract ERC1155GameItems is ERC1155, Ownable, Pausable, ERC1155Burnable {
    uint256 public constant GOLD = 0;
    uint256 public constant SILVER = 1;
    uint256 public constant THORS_HAMMER = 2;
    uint256 public constant SWORD = 3;
    uint256 public constant DICK = 4; 
    // uint256 public constant MINT_PRICE = 0.001 ether;

    string private uri_;
    string private baseUri =
        "ipfs://QmdaZqWqnxWmDTRGq5QTeH76j17sYAKWW5qcexmKYMnWP5/{id}.json";
    mapping(uint256 => string) private _uris; 

    constructor() ERC1155(baseUri) {
        uri_ = baseUri;
        _setURI(baseUri);
        _mint(msg.sender, GOLD, 100, "");
        _uris[GOLD] = baseUri;
        _mint(msg.sender, SILVER, 10 * 18, "");
        _uris[SILVER] = baseUri;
        _mint(msg.sender, THORS_HAMMER, 100, "");
        _uris[THORS_HAMMER] = baseUri;
        _mint(msg.sender, SWORD, 10 * 9, "");
        _uris[SWORD] = baseUri;
        _mint(msg.sender, DICK, 10, "");
        _uris[DICK] = baseUri;
    }

    // function uri(uint256 _tokenId) override public pure returns(string memory) {
    //     return string(
    //         abi.encodePacked(
    //             "https://bafybeicq4syucu6alfwwgomiprevdcmo6r4jk5bafgisezzl6tt7s46ipy.ipfs.dweb.link/{id}.json",
    //             Strings.toString(_tokenId),
    //             ".json"
    //         )
    //     );
    // }

    // function uri(uint256 _tokenId) override public pure returns(string memory) {
    //     return string(
    //         abi.encode(
    //             baseUri,  // _uris[_tokenId],
    //             Strings.toString(_tokenId),
    //             ".json"
    //         )
    //     );
    // }
    
    function uri(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        return _uris[_tokenId];
    }

    // доп изменять uri 
     function setTokenUri(uint256 tokenId, string memory _urii)
        public
        onlyOwner
    {
        if (tokenId < 5) { 
            uri_ = _urii;
            _uris[tokenId] = _urii;

        } else {
            require(
                bytes(_uris[tokenId]).length == 0,
                "Cannot set uri twise for this id"
            );
            _uris[tokenId] = _urii;
        }
    }

    function _setURI(string memory newuri) internal virtual override {
        uri_ = newuri;
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override whenNotPaused {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
}
