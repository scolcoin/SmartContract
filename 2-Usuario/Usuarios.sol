// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./VPS.sol";

contract Usuarios is Ownable {
    VPS public vpsContract;

    struct User {
        uint id;
        string nombre;
        string ccoNit;
        string email;
        string indicativo;
        string celular;
        string nickname;
        address wallet;
        address wallet_vps;
        bool user_auto;
    }

    User[] private users;
    uint public numusuario;

    event UsuarioModificado(address indexed usuario, address nuevaWalletVPS);

    constructor(address _vpsContract) Ownable() {
        vpsContract = VPS(_vpsContract);
    }

    function addUserVPS(
        address _wallet,
        string memory _nombre,
        string memory _ccoNit,
        string memory _email,
        string memory _indicativo,
        string memory _celular,
        string memory _nickname
    ) public onlyOwner {
        require(bytes(_nombre).length > 0, "Nombre is required");
        require(bytes(_ccoNit).length > 0, "CCoNit must be greater than 0");

        vpsContract.createVPS(_wallet, _nombre);

        numusuario++;
        User memory newUser = User(
            numusuario,
            _nombre,
            _ccoNit,
            _email,
            _indicativo,
            _celular,
            _nickname,
            _wallet,
            address(0),
            true
        );
        users.push(newUser);
    }

    function modifyWalletVPS(string memory _ccoNit, address nuevaWalletVPS) public onlyOwner {
        require(nuevaWalletVPS != address(0), "Wallet address is required");

        uint idUsuario = findCcoNit(_ccoNit);

        users[idUsuario - 1].wallet_vps = nuevaWalletVPS;
        vpsContract.modifyWalletVPS(users[idUsuario - 1].wallet, nuevaWalletVPS);

        emit UsuarioModificado(users[idUsuario - 1].wallet, nuevaWalletVPS);
    }

    function findCcoNit(string memory _ccoNit) internal view returns (uint) {
        for (uint i = 0; i < users.length; i++) {
            if (keccak256(bytes(users[i].ccoNit)) == keccak256(bytes(_ccoNit)) && users[i].user_auto) {
                return users[i].id;
            }
        }
        revert("Usuario no encontrado");
    }
}
