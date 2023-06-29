/**
 * @title Wallets
 * @dev Contrato inteligente para gestionar wallets de usuarios registrados en la red Scolcoin.
 * Este contrato incluye ID de cada miembro.
 * @custom:security-contact blockchaintechnologysas@gmail.com
 * ANN: esta plantilla es publica hace parte del universo BLOCKCHAIN TECHNOLOGY y la puede adoptar cualquier desarrollador
 * Empresa: BLOCKCHAIN TECHNOLOGY SOLUTIONS AND ARTIFICIAL INTELLIGENCE AI S.A.S
 */
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Wallets is Ownable {
    // USER
    struct Wallet {
        uint id_usu;
        uint id_vps;
        address wallet_otra;
    }

    // VPS Autorizados
    struct VPS {
        address vps;
        bool vps_auto;
    }

    Wallet[] private walletsList;
    VPS[] private vpsList;

    /**
     * @dev Crea una nueva wallet para un usuario.
     * @param _id_usu El ID del usuario.
     * @param _wallet_otra La dirección de la wallet.
     */
    function createWallet(uint _id_usu, address _wallet_otra) public {
        require(_wallet_otra != address(0), "Wallet address is required");
        address userAddress = msg.sender;
        uint nvid = findUVPS(userAddress);

        if (findVPS(userAddress)) {
            Wallet memory newUser = Wallet(_id_usu, nvid, _wallet_otra);
            walletsList.push(newUser);
        }
    }

    /**
     * @dev Consulta la wallet de un usuario por su ID.
     * @param _id_usu El ID del usuario.
     * @return Id El ID del usuario consultado.
     * @return cant La cantidad de wallets encontradas para el usuario.
     * @return List Un array de direcciones de wallets asociadas al usuario.
     */
    function Cons_id(uint _id_usu) public view returns (uint Id, uint cant, address[] memory List) {
        address userAddress = msg.sender;
        uint nvid = findUVPS(userAddress);
        address[] memory newArray = new address[](walletsList.length);

        // VPS autorizado
        if (findVPS(userAddress)) {
            uint newIndex = 0;

            for (uint i = 0; i < walletsList.length; i++) {
                Wallet memory wallet = walletsList[i];

                if (wallet.id_vps == nvid && wallet.id_usu == _id_usu) {
                    newArray[newIndex] = wallet.wallet_otra;
                    newIndex++;
                }
            }

            address[] memory finalArray = new address[](newIndex);
            for (uint i = 0; i < newIndex; i++) {
                finalArray[i] = newArray[i];
            }

            return (_id_usu, newIndex, finalArray);
        }
    }

    ///////////// VPS

    /**
     * @dev Crea un nuevo VPS autorizado.
     * @param _vps La dirección del VPS.
     */
    function createVPS(address _vps) public onlyOwner {
        require(_vps != address(0), "VPS address is required");
        require(checkUVPS(_vps), "Usuario duplicado");

        VPS memory newVPS = VPS(_vps, true);
        vpsList.push(newVPS);
    }

    /**
     * @dev Verifica si un VPS está duplicado.
     * @param _vps La dirección del VPS a verificar.
     * @return bool Indica si el VPS está duplicado o no.
     */
    function checkUVPS(address _vps) internal view returns (bool) {
        for (uint i = 0; i < vpsList.length; i++) {
            VPS memory vpsd = vpsList[i];
            if (vpsd.vps == _vps) {
                return false; // Usuario duplicado
            }
        }
        return true; // Usuario único
    }

    /**
     * @dev Autoriza o deniega un VPS.
     * @param _vps La dirección del VPS a autorizar o denegar.
     * @param _permiso El estado de autorización del VPS.
     */
    function AutoVPS(address _vps, bool _permiso) public onlyOwner {
        uint nvid = findUVPS(_vps);
        require(vpsList.length > 1, "No hay suficientes datos");

        vpsList[nvid].vps_auto = _permiso;
    }

    /**
     * @dev Busca un VPS por su dirección.
     * @param _vps La dirección del VPS a buscar.
     * @return uint El índice del VPS encontrado.
     */
    function findUVPS(address _vps) private view returns (uint) {
        for (uint i = 0; i < vpsList.length; i++) {
            VPS memory vps = vpsList[i];
            if (vps.vps == _vps) {
                return i;
            }
        }
        revert("Usuario no encontrado");
    }

    /**
     * @dev Busca un VPS por su dirección y estado de autorización.
     * @param _vps La dirección del VPS a buscar.
     * @return bool Indica si el VPS está autorizado o no.
     */
    function findVPS(address _vps) private view returns (bool) {
        for (uint i = 0; i < vpsList.length; i++) {
            VPS memory vps = vpsList[i];
            if (vps.vps == _vps && vps.vps_auto == true) {
                return true;
            }
        }
        return false;
    }

    /**
     * @dev Obtiene el ID del VPS por su dirección de wallet.
     * @param wallet La dirección de la wallet del VPS.
     * @return id El ID del VPS encontrado.
     */
    function id_VPS(address wallet) public view returns (uint id) {
        id = findUVPS(wallet);
        return id;
    }
}
