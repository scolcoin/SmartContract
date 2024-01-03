// SPDX-License-Identifier: MIT
// opt 5000 compiler 0.8.7+commite28d00a7
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./VPS.sol";

contract Usuarios is Ownable {
    struct User {
        uint id;
        string nombre;
        string ccoNit;
        string email;
        string indicativo;
        string celular;
        string nickname;
        address wallet;
        bool user_auto;
    }

    mapping(address => User) private users; // Mapping para buscar usuarios por dirección
    mapping(string => bool) private emailExists; // Mapping para verificar duplicados por email

    uint public numusuario;
    VPS public vpsContract; // Agregamos la declaración de la variable vpsContract

    event UsuarioModificado(address indexed usuario, address nuevaWalletVPS);

    modifier onlyVPS() {
    require(vpsContract.findUVPS(msg.sender) > 0, "VPS address not authorized in VPS.sol");
    _;
    }


    constructor(address _vpsContract) Ownable() {
        setVPSContract(_vpsContract);
    }

    function setVPSContract(address _vpsContract) public onlyOwner {
        require(_vpsContract != address(0), "VPS contract address cannot be zero");
        vpsContract = VPS(_vpsContract);
    }

    function addUser(
    address _wallet,
    string memory _nombre,
    string memory _ccoNit,
    string memory _email,
    string memory _indicativo,
    string memory _celular,
    string memory _nickname
) external onlyVPS {
    require(bytes(_nombre).length > 0, "Nombre es requerido");
    require(bytes(_ccoNit).length > 0, "CCoNit es requerido");
    require(bytes(_email).length > 0, "Email es requerido");
    require(bytes(_indicativo).length > 0, "Indicativo es requerido");
    require(bytes(_celular).length > 0, "Celular es requerido");
    require(bytes(_nickname).length > 0, "Usuario es requerido");
    require(!emailExists[_email], "User with this email already exists");

    // Verificar si la dirección de VPS está autorizada
    uint vpsId = vpsContract.findUVPS(msg.sender);
    require(vpsId > 0, "VPS address not authorized");

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
        true
    );

    users[_wallet] = newUser;
    emailExists[_email] = true;
}


    function modifyUser(
    address _user,
    string memory _nombre,
    string memory _ccoNit,
    string memory _email,
    string memory _indicativo,
    string memory _celular,
    string memory _nickname
) external onlyVPS {
    require(bytes(_nombre).length > 0, "Nombre es requerido");
    require(bytes(_ccoNit).length > 0, "CCoNit es requerido");
    require(bytes(_email).length > 0, "Email es requerido");
    require(bytes(_indicativo).length > 0, "Indicativo es requerido");
    require(bytes(_celular).length > 0, "Celular es requerido");
    require(bytes(_nickname).length > 0, "Usuario es requerido");
    require(users[_user].wallet != address(0), "User not found");

    // Eliminar el antiguo email del mapping de duplicados
    emailExists[users[_user].email] = false;

    // Actualizar los datos del usuario
    users[_user].nombre = _nombre;
    users[_user].ccoNit = _ccoNit;
    users[_user].email = _email;
    users[_user].indicativo = _indicativo;
    users[_user].celular = _celular;
    users[_user].nickname = _nickname;

    // Agregar el nuevo email al mapping de duplicados
    emailExists[_email] = true;

    emit UsuarioModificado(_user, users[_user].wallet);
}



function modifyUserWallet(address _user, address nuevaWallet) external onlyVPS {
    require(nuevaWallet != address(0), "Wallet address is required");
    require(users[_user].wallet != address(0), "User not found");

    users[_user].wallet = nuevaWallet;
    emit UsuarioModificado(_user, nuevaWallet);
}

// solo para VPS
    function getUserInfo(address _user) external onlyVPS view returns (User memory) {
        require(users[_user].wallet != address(0), "User not found");
        return users[_user];
    }

    // Otras funciones que puedas necesitar...
}
