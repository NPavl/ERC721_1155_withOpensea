// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
// https://docs.openzeppelin.com/contracts/4.x/wizard
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/PullPayment.sol";

// вариант рабочий но минус нет функции setTokenURI не могу изменить URI по id 
// не используй burb без необходимости так как поотом есть проблема с загрузкой 
// последующих токенов по id (подробне в desription.txt)

contract ERC721NFTBase2 is
    ERC721,
    PullPayment,
    ERC721URIStorage,
    Pausable,
    AccessControl,
    ERC721Burnable
{
    using Counters for Counters.Counter;

    // Constants
    uint256 public constant TOTAL_SUPPLY = 10_000;
    uint256 public constant MINT_PRICE = 0.001 ether;

    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("NFTContract", "NFT2") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function safeMint(address to, string memory uri)
        public payable
        onlyRole(MINTER_ROLE)
    {
        uint256 tokenId = _tokenIdCounter.current();
        require(tokenId < TOTAL_SUPPLY, "Max supply reached");
        require(msg.value == MINT_PRICE, "Transaction value did not equal the mint price");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override whenNotPaused {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    // The following functions are overrides required by Solidity.
    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    
    /// @dev Overridden in order to make it an onlyOwner function
  function withdrawPayments(address payable payee) public override onlyRole(DEFAULT_ADMIN_ROLE) virtual {
      super.withdrawPayments(payee);
  }
}
