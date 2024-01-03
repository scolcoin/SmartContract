// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Usuarios.sol"; // Importa el contrato Usuarios

contract VPS is Ownable {
    Usuarios public usuariosContract; // Asegúrate de importar el contrato Usuarios

    struct VPSData {
        uint Id;
        address vps;
        string empresa;
        bool vps_auto;
    }

    VPSData[] private vpsList;
    uint totalvps;

    // Constructor que recibe la dirección del contrato Usuarios
    constructor(address _usuariosContract) Ownable() {
        usuariosContract = Usuarios(_usuariosContract);
    }

    function createVPS(address _vps, string memory _empresa) public onlyOwner {
        uint userID = totalvps++;
        require(_vps != address(0), "VPS address is required");
        // Validaciones adicionales si es necesario
        // ...

        VPSData memory newVPS = VPSData(userID, _vps, _empresa, true);
        vpsList.push(newVPS);
    }

    function findUVPS(address _vps) public view returns (uint) {
        for (uint i = 0; i < vpsList.length; i++) {
            VPSData memory vps = vpsList[i];
            if (vps.vps == _vps) {
                return vps.Id;
            }
        }
        revert("VPS no encontrado");
    }

    // Agrega otras funciones según tus necesidades
    // ...

    // Modificar Usuario Wallet VPS
    function Modi_WVPS(
        address _vps,
        address nuevawallet_VPS
    ) public onlyOwner {
        uint idvps = findUVPS(_vps);

        require(nuevawallet_VPS != address(0), "Wallet address is required");

        vpsList[idvps].vps_auto = nuevawallet_VPS;
    }
}
