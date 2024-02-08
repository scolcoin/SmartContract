// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/utils/Counters.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/security/Pausable.sol";

contract MyNFT is ERC721, Ownable, Pausable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string private _baseTokenURI;

    constructor(string memory baseURI) ERC721("MyNFT", "MNFT") {
        _baseTokenURI = baseURI;
    }

    function mintNFT(address recipient) public returns (uint256) {
        _tokenIds.increment();

        uint256 newNFTId = _tokenIds.current(); // Usamos el ID actual del contador como ID del nuevo NFT
        _mint(recipient, newNFTId);

        return newNFTId;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function burn(uint256 tokenId) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "Caller is not owner nor approved");
        _burn(tokenId);
    }

    function pausar() public onlyOwner {
        if (paused()) {
            _unpause();
        } else {
            _pause();
        }
    }

    function cambiarBaseURI(string memory newBaseURI) public onlyOwner {
        _baseTokenURI = newBaseURI;
    }
}
