/** optimizacion 5000 y solidity ^0.8.0
@dev Usuario - Contrato inteligente para gestionar wallets de usuarios registrados en la red Scolcoin.
Este contrato incluye ID de cada miembro.
@custom:security-contact blockchaintechnologysas@gmail.com
ANN: esta plantilla es publica hace parte del universo BLOCKCHAIN TECHNOLOGY y la puede adoptar cualquier desarrollador
Empresa: BLOCKCHAIN TECHNOLOGY SOLUTIONS AND ARTIFICIAL INTELLIGENCE AI S.A.S*/
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
        bool    vps_auto;
    }

    Wallet[] private walletsList;
    VPS[] private vpsList;

//User
function createWallet(
        uint _id_usu,
        address _wallet_otra
    ) public {
        require(_wallet_otra != address(0), "Wallet address is required");
        address userAddress = msg.sender;
        uint nvid= findUVPS(userAddress);

        if(findVPS(userAddress)){
        Wallet memory newUser = Wallet(
            _id_usu,
            nvid,
            _wallet_otra
        );

        walletsList.push(newUser);
        }
    }

 // Consultar por id de usuario solo los VPS autorizados
    function Cons_id(uint _id_usu) public view returns (uint Id, uint cant, address[] memory List) {
        address userAddress = msg.sender;
        uint nvid = findUVPS(userAddress);

        address[] memory newArray = new address[](walletsList.length);  // Crear un nuevo array con el tamaño máximo posible

        // VPS autorizado
        if (findVPS(userAddress)) {
            uint newIndex = 0;  // Índice para rastrear la posición actual en newArray

            for (uint i = 0; i < walletsList.length; i++) {
                Wallet memory wallet = walletsList[i];

                if (wallet.id_vps == nvid && wallet.id_usu == _id_usu) {
                    newArray[newIndex] = wallet.wallet_otra;
                    newIndex++;

                }
            }

            // Redimensionar el array a la longitud exacta necesaria
            address[] memory finalArray = new address[](newIndex);
            for (uint i = 0; i < newIndex; i++) {
                finalArray[i] = newArray[i];
            }

            return (_id_usu,newIndex,finalArray);
        }
    }


///////////// VPS
  // VPS
  function createVPS(
        address _vps
    ) public onlyOwner {   
        require(_vps != address(0), "VPS address is required");
        //validaciones:
       require(checkUVPS(_vps), "Usuario duplicado");

        VPS memory newVPS = VPS(_vps, true);

        vpsList.push(newVPS);
        
    }  

    //buscar VPS Wallet
function checkUVPS(address _vps) internal view returns (bool) {
        for (uint i = 0; i < vpsList.length; i++) {
            VPS memory vpsd = vpsList[i];
            if (
                vpsd.vps == _vps
            ) {
                return false; // Usuario duplicado
            }
        }
        return true; // Usuario único
    }  

   //Autorizar VPS o Negar
    function AutoVPS(address _vps, bool _permiso) public onlyOwner {
        uint nvid= findUVPS(_vps);
        require(vpsList.length > 1, "No hay suficientes datos");

        vpsList[nvid].vps_auto = _permiso;
    } 
//buscar VPS Usuario
function findUVPS(address _vps) private view returns (uint) {
        for (uint i = 0; i < vpsList.length; i++) {
            VPS memory vps = vpsList[i];
            
                if (vps.vps == _vps) {
                    return i;
                }
            
        }
        revert("Usuario no encontrado");
    } 

//buscar VPS wallet
function findVPS(address _vps) private view returns (bool) {
        for (uint i = 0; i < vpsList.length; i++) {
            VPS memory vps = vpsList[i];
            
                if (vps.vps == _vps && vps.vps_auto==true ) {
                    return true;
                }
            
        }
        return false;
    } 

// ver VPS
      function id_VPS(  
        address wallet
        ) public view returns (
            uint id
            ) {
               id=findUVPS(wallet);  
               return(id);
            }

}

