// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

// https://docs.openzeppelin.com/contracts/4.x/erc721
// https://docs.openzeppelin.com/contracts/4.x/api/token/erc721

// contract tutorial https://docs.opensea.io/docs/part-3-adding-metadata-and-payments-to-your-contract
// contract tutorial part 2 https://docs.opensea.io/docs/4-setting-a-price-and-supply-limit-for-your-contract

// Simple tutorial for a customizable marketplace for buying and selling on OpenSea
// https://docs.opensea.io/docs/getting-started

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/PullPayment.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract ERC721NFTBase is ERC721, PullPayment, Ownable {
  using Counters for Counters.Counter;

  Counters.Counter private currentTokenId;

   // Constants
  uint256 public constant TOTAL_SUPPLY = 10_000;
  uint256 public constant MINT_PRICE = 0.001 ether;

  /// @dev Base token URI used as a prefix by tokenURI().
  string public baseTokenURI;

  constructor() ERC721("NFTSample", "NFT1") {
    baseTokenURI = "";
  }

    function mintTo(address recipient) public payable returns (uint256) { // payable (remix)
    uint256 tokenId = currentTokenId.current();
    require(tokenId < TOTAL_SUPPLY, "Max supply reached");
    require(msg.value == MINT_PRICE, "Transaction value did not equal the mint price");

    currentTokenId.increment();
    uint256 newItemId = currentTokenId.current();
    _safeMint(recipient, newItemId);
    return newItemId;
  }

  /// @dev Returns an URI for a given token ID
  function _baseURI() internal view virtual override returns (string memory) {
    return baseTokenURI;
  }

  /// @dev Sets the base token URI prefix.
  function setBaseTokenURI(string memory _baseTokenURI) public {
    baseTokenURI = _baseTokenURI;
  }

    /// @dev Overridden in order to make it an onlyOwner function
  function withdrawPayments(address payable payee) public override onlyOwner virtual {
      super.withdrawPayments(payee);
  }
}