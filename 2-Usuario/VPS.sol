// SPDX-License-Identifier: MIT
// opt 5000 compiler 0.8.7+commite28d00a7
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Usuarios.sol";

contract VPS is Ownable {
    Usuarios public usuariosContract;

    struct VPSData {
        uint id;
        address vps;
        string empresa;
        bool vps_auto;
    }

    VPSData[] private vpsList;
    uint public totalVPS;

    event UsuarioModificado(address indexed usuario, address nuevaWalletVPS);

    constructor(address _usuariosContract) Ownable() {
        usuariosContract = Usuarios(_usuariosContract);
    }

    function createVPS(string memory _empresa, address _vpsWallet) public onlyOwner {
        uint vpsId = totalVPS++;
        require(_vpsWallet != address(0), "VPS wallet address is required");

        VPSData memory newVPSData = VPSData(vpsId, _vpsWallet, _empresa, true);
        vpsList.push(newVPSData);

        // Agregar el nuevo VPS como usuario universal
        //usuariosContract.addUser(_vpsWallet, "", "", "", "", "", "");
    }

    function modifyWalletVPS(address _vps, address nuevaWalletVPS) public onlyOwner {
        uint vpsId = findUVPS(_vps);
        require(nuevaWalletVPS != address(0), "Wallet address is required");

        vpsList[vpsId].vps = nuevaWalletVPS;

        // Modificar la dirección de la wallet en el contrato de Usuarios
        usuariosContract.modifyUserWallet(_vps, nuevaWalletVPS);
        emit UsuarioModificado(_vps, nuevaWalletVPS);
    }

    function findUVPS(address _vps) public view returns (uint) {
        for (uint i = 0; i < vpsList.length; i++) {
            VPSData memory vps = vpsList[i];
            if (vps.vps == _vps) {
                return vps.id;
            }
        }
        revert("VPS no encontrado");
    }
}
