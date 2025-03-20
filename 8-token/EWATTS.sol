/// * @title EWATTS Token (EWG)
/// * @dev ERC20 token with minting and burning capabilities, owned by Watts Enterprise Group SAS.
/// * @author Watts Enterprise Group SAS
/// * @contact info@ewatts.co
/// * @website www.ewatts.co
/// * @custom:whatsapp +57 3122908166
/// * @custom: OPT 5000
/// * @custm: 0x454B1D1FC8ca39be358FAE728F8aC6d448910711
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC20/ERC20.sol";

/**
 * @title Token_EWATTS
 * @dev Implementación de un token ERC20 llamado EWATTS (EWG) con funcionalidades de quema y minteo.
 * @notice Este contrato es propiedad de Watts Enterprise Group SAS (NIT 901383241).
 */
contract Token_EWATTS is ERC20, ERC20Burnable, Ownable {
    uint8 private constant _decimals = 18;

    /**
     * @notice Constructor que inicializa el contrato y asigna un suministro inicial al propietario.
     * @param initialOwner Dirección que recibirá el suministro inicial de tokens.
     */
    constructor(address initialOwner) ERC20("EWATTS", "EWG") {    
        _mint(initialOwner, 1100000 * 10 ** _decimals);
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
