/// * @title HERZIA Token (HIA)
/// * @dev ERC20 token with minting and burning capabilities, owned by Watts Enterprise Group SAS.
/// * @author Watts Enterprise Group SAS
/// * @contact info@ewatts.co
/// * @website www.ewatts.co
/// * @custom:whatsapp +57 3205032082
/// * @custom: OPT 5000
/// * @custm: 0x949F30cB7C5289f66391e380177ef8f5E1f5D434
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC20/ERC20.sol";

/**
 * @title Token_HERZIA
 * @dev Implementación de un token ERC20 llamado HERZIA (HIA) con funcionalidades de quema y minteo.
 * @notice Este contrato es propiedad de Watts Enterprise Group SAS (NIT 901383241).
 */
contract Token_HERZIA is ERC20, ERC20Burnable, Ownable {
    uint8 private constant _decimals = 18;

    /**
     * @notice Constructor que inicializa el contrato y asigna un suministro inicial al propietario.
     * @param initialOwner Dirección que recibirá el suministro inicial de tokens.
     */
    constructor(address initialOwner) ERC20("HERZIA", "HIA") {    
        _mint(initialOwner, 15000000 * 10 ** _decimals);
    }

    /**
     * @notice Permite al propietario minar nuevos tokens y asignarlos a una dirección específica.
     * @dev Solo el propietario puede llamar a esta función.
     * @param to Dirección que recibirá los tokens minteados.
     * @param amount Cantidad de tokens a minar.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
