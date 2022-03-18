// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
// https://docs.opensea.io/docs/opensea-erc1155-tutorial
// https://docs.openzeppelin.com/contracts/4.x/wizard
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol
// ERC1155 data parameter on mint method:
// https://forum.openzeppelin.com/t/erc1155-data-parameter-on-mint-method/4393
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract ERC1155GameItems is ERC1155, Ownable, Pausable, ERC1155Burnable {
    uint256 public constant GOLD = 0;
    uint256 public constant SILVER = 1;
    uint256 public constant THORS_HAMMER = 2;
    uint256 public constant SWORD = 3;
    uint256 public constant DICK = 4;

    // https://www.youtube.com/watch?v=19SSvs32m8I пример 

    // если будешь добавлять больше в конструктор проверь setTokenUri и поменяй if tokenId < 5 на актуальное значение 

    // "https://bafybeicq4syucu6alfwwgomiprevdcmo6r4jk5bafgisezzl6tt7s46ipy.ipfs.dweb.link/{id}.json"

    string private uri_;
    string private baseUri =
        "https://bafybeicq4syucu6alfwwgomiprevdcmo6r4jk5bafgisezzl6tt7s46ipy.ipfs.dweb.link/metadata/{id}.json";
    mapping(uint256 => string) private _uris; // для хранения уникальных uri

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

    //    function uri(uint256 _tokenId) override public pure returns(string memory) {
    //     return string(
    //         abi.encodePacked(
    //             _uris[_tokenId],
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

    // доп реализация setTokenUri возможность изменять uri под разные storage  
     function setTokenUri(uint256 tokenId, string memory _urii)
        public
        onlyOwner
    {
        if (tokenId < 5) {  // возможность изменить uri для uri первоначальных id переданных при инициализ в конструктор  
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
