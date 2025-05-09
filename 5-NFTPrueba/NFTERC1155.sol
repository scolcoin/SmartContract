// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {ERC1155} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/token/ERC1155/ERC1155.sol";
import {Ownable} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/access/Ownable.sol";

contract GameItems is ERC1155, Ownable {
    // IDs de los tokens
    uint256 public constant GOLD = 0;
    uint256 public constant SILVER = 1;
    uint256 public constant SWORD = 2;
    uint256 public constant SHIELD = 3;
    
    constructor() ERC1155("https://game.example/api/item/{id}.json") {
        // Mint inicial de tokens
        _mint(msg.sender, GOLD, 10**18, ""); // 1 millón de tokens GOLD
        _mint(msg.sender, SILVER, 10**24, ""); // 1 millón de tokens SILVER
        _mint(msg.sender, SWORD, 1000, ""); // 1000 espadas
        _mint(msg.sender, SHIELD, 1000, ""); // 1000 escudos
    }

    // Función para crear nuevos items (solo el owner)
    function mint(address account, uint256 id, uint256 amount, bytes memory data) public onlyOwner {
        _mint(account, id, amount, data);
    }

    // Función para crear lotes de nuevos items
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    // Cambiar la URI base
    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
    
    // Ejemplo de función para "quemar" tokens (eliminarlos)
    function burn(address account, uint256 id, uint256 amount) public {
        require(account == msg.sender || isApprovedForAll(account, msg.sender), "No autorizado");
        _burn(account, id, amount);
    }
}
