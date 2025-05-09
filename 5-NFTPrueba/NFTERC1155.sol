// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {ERC1155} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/token/ERC1155/ERC1155.sol";
import {Ownable} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/access/Ownable.sol";

contract SimpleERC1155 is ERC1155, Ownable {
    // IDs de tokens
    uint256 public constant TOKEN_1 = 1;
    uint256 public constant TOKEN_2 = 2;
    
    constructor() ERC1155("https://example.com/api/token/{id}.json") {
        // Transferir ownership al deployer (esto es necesario en v4.5.0)
        transferOwnership(msg.sender);
        
        // Mint inicial de tokens al deployer
        _mint(msg.sender, TOKEN_1, 100, ""); // 100 unidades de TOKEN_1
        _mint(msg.sender, TOKEN_2, 50, "");  // 50 unidades de TOKEN_2
    }

    function mint(address to, uint256 id, uint256 amount) public onlyOwner {
        _mint(to, id, amount, "");
    }

    function burn(address account, uint256 id, uint256 amount) public {
        require(account == msg.sender || isApprovedForAll(account, msg.sender), "No autorizado");
        _burn(account, id, amount);
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
}
