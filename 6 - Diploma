// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importaciones de contratos de OpenZeppelin
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/utils/structs/EnumerableSet.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/token/ERC721/ERC721.sol";

// Contrato principal para gestionar diplomas
contract DiplomaMaster is ERC721, Ownable {
    // Uso de la librería EnumerableSet para conjuntos de direcciones
    using EnumerableSet for EnumerableSet.AddressSet;

    // Estructura que define un Diploma
    struct Diploma {
        string nombre;      // Nombre del titular del diploma
        uint256 cedula;     // Número de identificación del titular
        uint256 horas;      // Número de horas del curso
        uint256 modulos;    // Número de módulos del curso
        uint256 nivel;      // Nivel del diploma
        string metodologia; // Metodología del curso
        string URI;         // URI del diploma (ubicación del archivo)
        address wallet;     // Dirección del titular del diploma
    }

    // Mapeo de ID de diploma a su estructura Diploma correspondiente
    mapping(uint256 => Diploma) public diplomas;
    // Mapeo de direcciones de VPS autorizadas
    mapping(address => bool) public isVPSAuthorized;
    // Mapeo de ID de diploma a su URI
    mapping(uint256 => string) private _tokenURIs;

    // Conjunto de direcciones de VPS autorizadas
    EnumerableSet.AddressSet private authorizedVPS;

    // Evento emitido cuando se autoriza o desautoriza una VPS
    event VPSAuthorized(address indexed vps, bool status);

    // Contador de ID de diploma
    uint256 private _tokenIdCounter;

    // Constructor del contrato
    constructor() ERC721("DiplomaMaster", "DM") {}

    // Función para almacenar un diploma
    function almacenarDiploma(
        uint256 tokenId,        // ID del diploma a asignar
        string memory _nombre,  // Nombre del titular del diploma
        uint256 _cedula,        // Número de identificación del titular
        uint256 _horas,         // Número de horas del curso
        uint256 _modulos,       // Número de módulos del curso
        uint256 _nivel,         // Nivel del diploma
        string memory _metodologia, // Metodología del curso
        string memory _URI,     // URI del diploma
        address _wallet         // Dirección del titular del diploma
    ) external onlyAuthorizedVPS { // Solo VPS autorizada puede llamar a esta función
        require(!_exists(tokenId), "El ID de diploma ya esta en uso");

        // Crear el diploma y asignarlo al ID correspondiente
        diplomas[tokenId] = Diploma({
            nombre: _nombre,
            cedula: _cedula,
            horas: _horas,
            modulos: _modulos,
            nivel: _nivel,
            metodologia: _metodologia,
            URI: _URI,
            wallet: _wallet
        });

        // Emitir el evento de creación de diploma
        emit Transfer(address(0), msg.sender, tokenId);

        // Almacenar el URI del diploma
        setTokenURI(tokenId, _URI); 
    }

    // Función para consultar un diploma por su ID
    function consultarDiploma(uint256 tokenId) external view returns (Diploma memory) {
        require(_exists(tokenId), "El ID de diploma no existe");
        return diplomas[tokenId];
    }

    // Función para consultar el URI de un diploma por su ID
    function consultarURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "El ID de diploma no existe");
        return tokenURI(tokenId); 
    }

    // Función para autorizar o desautorizar una VPS
    function authorizeVPS(address _vps, bool _status) external onlyOwner {
        if (_status) {
            authorizedVPS.add(_vps);
        } else {
            authorizedVPS.remove(_vps);
        }
        isVPSAuthorized[_vps] = _status;
        emit VPSAuthorized(_vps, _status);
    }

    // Función para establecer el URI de un diploma
    function setTokenURI(uint256 tokenId, string memory _tokenURI) internal {
        _tokenURIs[tokenId] = _tokenURI;
    }

    // Función para obtener el URI de un diploma por su ID
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "El ID de diploma no existe");
        return _tokenURIs[tokenId];
    }

    // Función para verificar si un diploma existe
    function _exists(uint256 tokenId) internal view override returns (bool) {
        return bytes(_tokenURIs[tokenId]).length > 0;
    }

    // Modificador para restringir el acceso a las funciones solo a VPS autorizadas
    modifier onlyAuthorizedVPS() {
        require(isVPSAuthorized[msg.sender], "VPS no autorizada");
        _;
    }
}
