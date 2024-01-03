// SPDX-License-Identifier: MIT
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

    constructor(address _usuariosContract) Ownable() {
        usuariosContract = Usuarios(_usuariosContract);
    }

    function createVPS(address _vps, string memory _empresa) public onlyOwner {
        uint vpsId = totalVPS++;
        require(_vps != address(0), "VPS address is required");

        VPSData memory newVPS = VPSData(vpsId, _vps, _empresa, true);
        vpsList.push(newVPS);
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

    function modifyWalletVPS(address _vps, address nuevaWalletVPS) public onlyOwner {
        uint vpsId = findUVPS(_vps);

        require(nuevaWalletVPS != address(0), "Wallet address is required");

        vpsList[vpsId].vps = nuevaWalletVPS;
    }
}
