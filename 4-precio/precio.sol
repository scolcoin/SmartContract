// SPDX-License-Identifier: MIT

/**
 * @title Precios
 * @dev Lista con precios actualizados en cada transacciones.
 * @author BLOCKCHAIN TECHNOLOGY SOLUTIONS AND ARTIFICIAL INTELLIGENCE AI S.A.S
 * @NIT: 901676524-7
 * @notice Este contrato implementa una lista publica.
 * @custom: https://blockchaintechnologysas.com/
 * @custom:email blockchaintechnologysas@gmail.com
 * @custom:whatsapp +57 3157619684
 * @custom: OPT 5000
 * @custm: 0xF51e3C802feA295B24B3F0328eC03c3A27eecA71
 */

pragma solidity ^0.8.7;

contract Precios {
    address public owner;
    mapping(address => bool) public vpsAutorizados;
    mapping(string => bool) private preciosRegistrados;
    
    struct Precio {
        uint256 cop;
        uint256 usd; // dolar
        uint256 gbp; //libra esterlina
        uint256 cny; // yuan
        uint256 jpy; // yen japonés
        uint256 eur; // euro
        uint256 brl; // brasil
        uint256 btc; // bitcoin
        address wallet; // dirección de la billetera
        bool status; // estado
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

    function agregarVPS(address _vps) public onlyOwner {
        vpsAutorizados[_vps] = true;
    }

    function agregarPrecio( // en centavos * 100
        string memory _nombre,
        uint256 _cop,  
        uint256 _usd,  
        uint256 _gbp,  
        uint256 _cny,
        uint256 _jpy,
        uint256 _eur,
        uint256 _brl,
        uint256 _btc,
        address _wallet,
        bool _status
    ) public onlyVPS {
        require(!preciosRegistrados[_nombre], "El nombre de precio ya esta registrado");
        precios[_nombre] = Precio(_cop, _usd, _gbp, _cny, _jpy, _eur, _brl, _btc, _wallet, _status);
        preciosRegistrados[_nombre] = true;
    }

    function actualizarPrecio( // en centavos * 100
        string memory _nombre,
        uint256 _cop,
        uint256 _usd,
        uint256 _gbp,
        uint256 _cny,
        uint256 _jpy,
        uint256 _eur,
        uint256 _brl,
        uint256 _btc,
        address _wallet,
        bool _status
    ) public onlyVPS {
        require(preciosRegistrados[_nombre], "El nombre de precio no existe");
        precios[_nombre] = Precio(_cop, _usd, _gbp, _cny, _jpy, _eur, _brl, _btc, _wallet, _status);
    }

    function transferirPropiedad(address _nuevoPropietario) public onlyOwner {
        owner = _nuevoPropietario;
    }

    function existePrecio(string memory _nombre) public view returns (bool) {
        return preciosRegistrados[_nombre];
    }

    function actualizarStatus(string memory _nombre, bool _status) public onlyVPS {
        require(preciosRegistrados[_nombre], "El nombre de precio no existe");
        precios[_nombre].status = _status;
    }

    function verStatus(string memory _nombre) public view returns (bool) {
        require(preciosRegistrados[_nombre], "El nombre de precio no existe");
        return precios[_nombre].status;
    }
}
