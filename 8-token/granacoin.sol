// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title Granacoin Token (GRACO)
 * @dev Token ERC-20 con quema habilitada, suministro fijo y función de staking múltiple.
 * @dev Los usuarios pueden hacer múltiples staking con un mínimo de 200 GRACO cada uno, con un período de 1 año y un 10% de recompensa.
 * @author Grupo Empresarial Granacoin SAS
 * @NIT: 901766123-3
 * @notice Este contrato implementa un token no minable con staking anual.
 * @custom:Token https://token.granacoin.com.co/
 * @Custom: Website: https://grupoempresarialgranacoin.com/
 * @custom:Shop: https://tienda.grupoempresarialgranacoin.com/
 * @custom:email granacoin.graco@gmail.com
 * @custom:whatsapp +57 3122908166
 * @custom: OPT 5000
 * @custm: 0x59A16357348667ABcB0C25dBA4262527c72ce397
 */

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC20/ERC20.sol";

contract Token_Granacoin is ERC20, ERC20Burnable, Ownable {

    uint8 private constant _decimals = 18;
    uint256 public constant maxSupply = 15000000 * 10 ** _decimals;
    uint256 public constant minStakeAmount = 200 * 10 ** _decimals;
    uint256 public constant stakeDuration = 365 days;
    uint256 public constant annualReward = 10; // 10%

    struct Stake {
        uint256 amount;
        uint256 startTime;
        bool claimed;
    }

    mapping(address => Stake[]) public stakes;

    constructor(address initialOwner) ERC20("Granacoin", "GRACO") {
        _mint(initialOwner, maxSupply); // Se mintea el total de una vez
    }

    /**
     * @dev Permite a los usuarios bloquear tokens en múltiples staking.
     * @param amount Cantidad de tokens a bloquear (mínimo 200 GRACO por staking).
     */
    function stake(uint256 amount) external {
        require(amount >= minStakeAmount, "El monto minimo de staking es 200 GRACO");
        _transfer(msg.sender, address(this), amount);
        stakes[msg.sender].push(Stake(amount, block.timestamp, false));
    }

    /**
     * @dev Permite reclamar la recompensa del staking después de 1 año para cada uno de los staking activos.
     * @param index Índice del staking a reclamar dentro del array del usuario.
     */
    function claimReward(uint256 index) external {
        require(index < stakes[msg.sender].length, "Indice de staking invalido");
        Stake storage userStake = stakes[msg.sender][index];
        require(userStake.amount > 0, "No tienes staking activo en este indice");
        require(block.timestamp >= userStake.startTime + stakeDuration, "El staking aun no ha finalizado");
        require(!userStake.claimed, "Recompensa ya reclamada");
        
        uint256 reward = (userStake.amount * annualReward) / 100;
        _mint(msg.sender, reward);
        userStake.claimed = true;
    }

    /**
     * @dev Devuelve la cantidad de decimales utilizada en el token.
     * @return Número de decimales (18 por defecto en ERC-20)
     */
    function decimals() public pure override returns (uint8) {
        return _decimals;
    }
}
