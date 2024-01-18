// SPDX-License-Identifier: MIT
// opt 5000 compiler 0.8.7+commite28d00a7
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Usuarios is Ownable {

    event UsuarioModificado(address indexed vps, address nuevaWalletVPS);
    event UsuarioExistente(bool existe);

    struct DatosVPS {
        uint id;
        address vps;
        string empresa;
        bool vps_auto;
    }

    struct Usuario {
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

    uint public numusuario;

    DatosVPS[] private listaVPS;
    Usuario[] private listaUsuarios;

    modifier soloVPS() {
        require(isVPS(msg.sender) && listaVPS[encontrarIDVPS(msg.sender)].vps_auto, "Solo los VPS autorizados y activos pueden llamar a esta funcion");
        _;
    }

    function isVPS(address _vpsAddress) public view returns (bool) {
        for (uint i = 0; i < listaVPS.length; i++) {
            if (listaVPS[i].vps == _vpsAddress && listaVPS[i].vps_auto) {
                return true;
            }
        }
        return false;
    }

function agregarVPS(address _vps, string memory _empresa, bool _vps_auto) external onlyOwner {
    // Verificar si la dirección del VPS ya existe
    require(!vpsExistePorWallet(_vps), "La wallet del VPS ya existe");

    // Código para agregar el VPS
    uint idVPS = listaVPS.length;
    listaVPS.push(DatosVPS({
        id: idVPS,
        vps: _vps,
        empresa: _empresa,
        vps_auto: _vps_auto
    }));
}

function vpsExistePorWallet(address _vps) public view returns (bool) {
    for (uint i = 0; i < listaVPS.length; i++) {
        if (listaVPS[i].vps == _vps) {
            return true;
        }
    }
    return false;
}


    function agregarUsuario(
    string memory _nombre,
    string memory _ccoNit,
    string memory _email,
    string memory _indicativo,
    string memory _celular,
    string memory _nickname,
    address _wallet,
    bool _user_auto
) external soloVPS {
    // Validaciones adicionales del código existente
    require(bytes(_nombre).length > 0, "Nombre es requerido");
    require(bytes(_ccoNit).length > 0, "CCoNit es requerido");
    require(bytes(_email).length > 0, "Email es requerido");
    require(bytes(_indicativo).length > 0, "Indicativo es requerido");
    require(bytes(_celular).length > 0, "Celular es requerido");
    require(bytes(_nickname).length > 0, "Usuario es requerido");

    // Verificar si la dirección del VPS está autorizada
    uint idVPS = encontrarIDVPS(msg.sender);
    require(idVPS > 0, "Direccion del VPS no autorizada");

    // Verificar si la wallet ya existe
    require(!usuarioExistePorWallet(_wallet), "La wallet ya existe");

    // Código para agregar el usuario
    numusuario++;
    Usuario memory nuevoUsuario = Usuario(
        numusuario,
        _nombre,
        _ccoNit,
        _email,
        _indicativo,
        _celular,
        _nickname,
        _wallet,
        _user_auto
    );

    listaUsuarios.push(nuevoUsuario);
}


    function obtenerUsuario(uint _userId) external view onlyOwner returns (Usuario memory) {
        require(_userId < listaUsuarios.length, "Usuario no existe");
        return listaUsuarios[_userId];
    }

    function modificarWalletVPS(address _vps, address nuevaWalletVPS) public onlyOwner {
        uint idVPS = encontrarIDVPS(_vps);
        require(nuevaWalletVPS != address(0), "Se requiere la direccion de la billetera");

        listaVPS[idVPS].vps = nuevaWalletVPS;

        emit UsuarioModificado(_vps, nuevaWalletVPS);
    }

    function modificarWalletUsuario(address _usuario, address nuevaWallet) external soloVPS {
        require(nuevaWallet != address(0), "Se requiere la direccion de la billetera");

        uint idUsuario = encontrarUsuario(_usuario);

        // Validar que el usuario exista y que el VPS sea autorizado
        require(idUsuario < listaUsuarios.length, "Usuario no encontrado");
        require(isVPS(msg.sender), "Solo los VPS autorizados pueden llamar a esta funcion");

        listaUsuarios[idUsuario].wallet = nuevaWallet;
        emit UsuarioModificado(_usuario, nuevaWallet);
    }

    function usuarioExistePorWallet(address _wallet) public view returns (bool) {
        for (uint i = 0; i < listaUsuarios.length; i++) {
            if (listaUsuarios[i].wallet == _wallet) {
                return true;
            }
        }
        return false;
    }

    function usuarioExistePorId(uint _userId) external view soloVPS returns (bool) {
        require(_userId < listaUsuarios.length, "Usuario no existe");
        return true;
    }

    function obtenerNombreVPSPorWallet(address _vpsWallet) external view returns (string memory) {
        for (uint i = 0; i < listaVPS.length; i++) {
            if (listaVPS[i].vps == _vpsWallet && listaVPS[i].vps_auto) {
                return listaVPS[i].empresa;
            }
        }
        revert("VPS no encontrado");
    }

    function encontrarIDVPS(address _vps) internal view returns (uint) {
        for (uint i = 0; i < listaVPS.length; i++) {
            if (listaVPS[i].vps == _vps) {
                return listaVPS[i].id;
            }
        }
        revert("VPS no encontrado");
    }

    function encontrarUsuario(address _wallet) public view returns (uint) {
        for (uint i = 0; i < listaUsuarios.length; i++) {
            if (listaUsuarios[i].wallet == _wallet) {
                return i;
            }
        }
        revert("Usuario no encontrado");
    }

    function modificarUsuario(
        string memory _nombre,
        string memory _ccoNit,
        string memory _email,
        string memory _indicativo,
        string memory _celular,
        string memory _nickname,
        address _wallet
    ) external soloVPS {
        uint idUsuario = encontrarUsuario(_wallet);

        // Validaciones adicionales del código existente
        require(bytes(_nombre).length > 0, "Nombre es requerido");
        require(bytes(_ccoNit).length > 0, "CCoNit es requerido");
        require(bytes(_email).length > 0, "Email es requerido");
        require(bytes(_indicativo).length > 0, "Indicativo es requerido");
        require(bytes(_celular).length > 0, "Celular es requerido");
        require(bytes(_nickname).length > 0, "Usuario es requerido");

        // Actualizar los datos del usuario
        listaUsuarios[idUsuario].nombre = _nombre;
        listaUsuarios[idUsuario].ccoNit = _ccoNit;
        listaUsuarios[idUsuario].email = _email;
        listaUsuarios[idUsuario].indicativo = _indicativo;
        listaUsuarios[idUsuario].celular = _celular;
        listaUsuarios[idUsuario].nickname = _nickname;

        emit UsuarioModificado(listaUsuarios[idUsuario].wallet, listaUsuarios[idUsuario].wallet);
    }

    function modificarEstadoAutoUsuario(address _usuario, bool nuevoEstadoAutoUsuario) external soloVPS {
        uint idUsuario = encontrarUsuario(_usuario);

        // Validar que el usuario exista y que el VPS sea autorizado
        require(idUsuario < listaUsuarios.length, "Usuario no encontrado");
        require(isVPS(msg.sender), "Solo los VPS autorizados pueden llamar a esta funcion");

        listaUsuarios[idUsuario].user_auto = nuevoEstadoAutoUsuario;
        emit UsuarioModificado(_usuario, listaUsuarios[idUsuario].wallet);
    }

    function obtenerDatosUsuarioPorId(uint _userId) external view soloVPS returns (Usuario memory) {
    require(_userId < listaUsuarios.length, "Usuario no encontrado");
    return listaUsuarios[_userId];
}


    function modificarEstadoAutoVPS(address _vps, bool nuevoEstadoAutoVPS) external onlyOwner {
        uint idVPS = encontrarIDVPS(_vps);

        // Validar que el VPS exista
        require(idVPS < listaVPS.length, "VPS no encontrado");

        listaVPS[idVPS].vps_auto = nuevoEstadoAutoVPS;
        emit UsuarioModificado(_vps, listaVPS[idVPS].vps);
    }
}
