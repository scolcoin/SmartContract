// SPDX-License-Identifier: MIT
// opt 5000 compiler 0.8.20
pragma solidity ^0.8.20;

contract ListaDePrecios {
    address public owner;
    mapping(address => bool) public vpsAutorizados;
    mapping(string => bool) private preciosRegistrados;
    
    struct Precio {
        uint256 cop;
        uint256 usd;
        uint256 jpy;
        uint256 pen;
        uint256 eur;
        uint256 brl;
        uint256 btc;
    }

    mapping(string => Precio) public precios; // en centavos / 100

    modifier onlyOwner() {
        require(msg.sender == owner, "Solo el propietario puede llamar a esta funcion");
        _;
    }

    modifier onlyVPS() {
        require(vpsAutorizados[msg.sender], "Solo los VPS autorizados pueden llamar a esta funcion");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function agregarVPS(address _vps, string memory /*_wallet*/) public onlyOwner {
        vpsAutorizados[_vps] = true;
    }

    function agregarPrecio( // en centavos * 100
        string memory _nombre,
        uint256 _cop,  
        uint256 _usd,  
        uint256 _jpy,  
        uint256 _pen,
        uint256 _eur,
        uint256 _brl,
        uint256 _btc
    ) public onlyVPS {
        require(!preciosRegistrados[_nombre], "El nombre de precio ya esta registrado");
        precios[_nombre] = Precio(_cop, _usd, _jpy, _pen, _eur, _brl, _btc);
        preciosRegistrados[_nombre] = true;
    }

    function actualizarPrecio( // en centavos * 100
        string memory _nombre,
        uint256 _cop,
        uint256 _usd,
        uint256 _jpy,
        uint256 _pen,
        uint256 _eur,
        uint256 _brl,
        uint256 _btc
    ) public onlyVPS {
        require(preciosRegistrados[_nombre], "El nombre de precio no existe");
        precios[_nombre] = Precio(_cop, _usd, _jpy, _pen, _eur, _brl, _btc);
    }

    function transferirPropiedad(address _nuevoPropietario) public onlyOwner {
        owner = _nuevoPropietario;
    }


}
