//10-nonce.sol
/// * @title Nonce API de Autenticación
/// * @dev contrato inteligente similar a un NFT.
/// * @author Blockchain Technology SAS
/// * @contact 	blockchaintechnologysas@gmail.com
/// * @website blockchaintechnologysas.com
/// * @custom:whatsapp +57 3157619684
/// * @custom: OPT 5000
/// * @custm: 0xED47008B9f80EA46c9230F5E5b43050433C7629f
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NonceManager {
    address public owner;
    uint256 public nextNonceId;
    
    struct Nonce {
        uint256 id;
        address owner;
        bool used;
        uint256 createdAt;
    }
    
    mapping(uint256 => Nonce) public nonces;
    
    event NonceCreated(uint256 indexed id, address indexed owner);
    event NonceUsed(uint256 indexed id, address indexed user);
    
    constructor() {
        owner = msg.sender;
        nextNonceId = 1; // Comenzamos desde 1
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }
    
    function createNonce() external onlyOwner returns (uint256) {
        uint256 currentId = nextNonceId;
        nonces[currentId] = Nonce({
            id: currentId,
            owner: owner,
            used: false,
            createdAt: block.timestamp
        });
        
        nextNonceId++;
        emit NonceCreated(currentId, owner);
        return currentId;
    }
    
    function useNonce(uint256 nonceId) external {
        require(nonces[nonceId].id != 0, "Nonce does not exist");
        require(!nonces[nonceId].used, "Nonce already used");
        
        nonces[nonceId].used = true;
        emit NonceUsed(nonceId, msg.sender);
    }
    
    function isValidNonce(uint256 nonceId) external view returns (bool) {
        return nonces[nonceId].id != 0 && !nonces[nonceId].used;
    }
}
