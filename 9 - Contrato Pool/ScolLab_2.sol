// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ScolLab_2 {
    address public owner;
    string public constant symbol = "SCOL";
    uint256 public miningRate = 1; // 1% inicial (1-50%)
    uint256 public constant lockPeriod = 365 days; // 12 meses
    
    // Límites de inversión ajustables
    uint256 public maxInvestment = 5000000 ether;
    uint256 public minInvestment = 1000001 ether;
    
    // Seguridad: Time-lock para cambios
    uint256 public constant CHANGE_DELAY = 3 days;
    uint256 public pendingMiningRate;
    uint256 public rateChangeTime;
    bool public rateChangePending;
    
    // Seguridad: Anti-reentrancy
    bool private _locked;
    
    struct Investment {
        uint256 amount;
        uint256 startTime;
        bool withdrawn;
    }
    
    mapping(address => Investment) public investments;
    address[] public investors;
    bool public isActive = true;
    
    // Eventos
    event MinInvestmentChanged(uint256 newMin);
    event MaxInvestmentChanged(uint256 newMax);
    event Invested(address indexed investor, uint256 amount);
    event Withdrawn(address indexed investor, uint256 amount, uint256 profit);
    event MiningRateChangeProposed(uint256 newRate, uint256 executeTime);
    event MiningRateChanged(uint256 newRate);
    event ContractKilled();
    event DonationReceived(address donor, uint256 amount);
    event OwnershipTransferred(address newOwner);
    
    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "SCOL: Solo el owner");
        _;
    }
    
    modifier contractIsActive() {
        require(isActive, "SCOL: Contrato inactivo");
        _;
    }
    
    modifier validInvestmentAmount() {
        require(
            msg.value >= minInvestment && msg.value <= maxInvestment,
            "SCOL: Monto invalido"
        );
        _;
    }

    modifier noReentrant() {
        require(!_locked, "SCOL: No reentrancy");
        _locked = true;
        _;
        _locked = false;
    }

    constructor() {
        owner = msg.sender;
    }

    function setMinInvestment(uint256 newMin) external onlyOwner {
        require(newMin > 0, "SCOL: Minimo debe ser > 0");
        require(newMin < maxInvestment, "SCOL: Minimo debe ser < maximo");
        minInvestment = newMin;
        emit MinInvestmentChanged(newMin);
    }

    function setMaxInvestment(uint256 newMax) external onlyOwner {
        require(newMax > minInvestment, "SCOL: Maximo debe ser > minimo");
        maxInvestment = newMax;
        emit MaxInvestmentChanged(newMax);
    }

    function invest() external payable contractIsActive noReentrant validInvestmentAmount {
        require(investments[msg.sender].amount == 0, "SCOL: Inversion existente");
        
        investments[msg.sender] = Investment({
            amount: msg.value,
            startTime: block.timestamp,
            withdrawn: false
        });
        
        investors.push(msg.sender);
        emit Invested(msg.sender, msg.value);
    }

    function withdraw() external contractIsActive noReentrant {
        Investment storage userInvestment = investments[msg.sender];
        require(userInvestment.amount > 0, "SCOL: Sin inversion");
        require(!userInvestment.withdrawn, "SCOL: Ya retirado");
        require(block.timestamp >= userInvestment.startTime + lockPeriod, "SCOL: Periodo no cumplido");
        
        uint256 profit = (userInvestment.amount * miningRate) / 100;
        uint256 totalAmount = userInvestment.amount + profit;
        
        require(address(this).balance >= totalAmount, "SCOL: Fondos insuficientes");
        
        userInvestment.withdrawn = true;
        (bool success, ) = msg.sender.call{value: totalAmount}("");
        require(success, "SCOL: Transfer failed");
        
        emit Withdrawn(msg.sender, userInvestment.amount, profit);
    }

    function proposeMiningRateChange(uint256 newRate) external onlyOwner {
        require(newRate > 0 && newRate <= 50, "SCOL: Tasa invalida (1-50%)");
        pendingMiningRate = newRate;
        rateChangeTime = block.timestamp + CHANGE_DELAY;
        rateChangePending = true;
        emit MiningRateChangeProposed(newRate, rateChangeTime);
    }

    function confirmMiningRateChange() external onlyOwner {
        require(rateChangePending, "SCOL: Sin cambios pendientes");
        require(block.timestamp >= rateChangeTime, "SCOL: Tiempo no cumplido");
        
        miningRate = pendingMiningRate;
        rateChangePending = false;
        emit MiningRateChanged(miningRate);
    }

    function killContract() external onlyOwner contractIsActive noReentrant {
        isActive = false;
        
        for (uint256 i = 0; i < investors.length; i++) {
            address investor = investors[i];
            Investment memory userInvestment = investments[investor];
            
            if (!userInvestment.withdrawn && userInvestment.amount > 0) {
                uint256 profit = (userInvestment.amount * miningRate) / 100;
                uint256 totalAmount = userInvestment.amount + profit;
                
                if (address(this).balance >= totalAmount) {
                    investments[investor].withdrawn = true;
                    (bool success, ) = investor.call{value: totalAmount}("");
                    require(success, "SCOL: Pago fallido");
                }
            }
        }
        
        uint256 remainingBalance = address(this).balance;
        if (remainingBalance > 0) {
            (bool success, ) = owner.call{value: remainingBalance}("");
            require(success, "SCOL: Transfer final fallida");
        }
        
        emit ContractKilled();
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "SCOL: Owner invalido");
        owner = newOwner;
        emit OwnershipTransferred(newOwner);
    }

    function getRemainingTime(address investor) external view returns (uint256) {
        Investment memory userInvestment = investments[investor];
        if (userInvestment.amount == 0 || userInvestment.withdrawn) return 0;
        
        if (block.timestamp >= userInvestment.startTime + lockPeriod) {
            return 0;
        } else {
            return (userInvestment.startTime + lockPeriod) - block.timestamp;
        }
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getUserInvestment(address user) external view returns (
        uint256 amount, 
        uint256 startTime, 
        bool withdrawn
    ) {
        Investment memory investment = investments[user];
        return (investment.amount, investment.startTime, investment.withdrawn);
    }

    // Nuevas funciones para admin
    function getRequiredContractBalance() external view onlyOwner returns (uint256) {
        uint256 totalInvestments;
        
        for (uint256 i = 0; i < investors.length; i++) {
            Investment memory inv = investments[investors[i]];
            if (!inv.withdrawn && inv.amount > 0) {
                totalInvestments += inv.amount;
            }
        }
        
        return totalInvestments + (totalInvestments * miningRate) / 100;
    }

    function getBalanceDeficit() external view onlyOwner returns (int256) {
        uint256 required = this.getRequiredContractBalance();
        uint256 current = address(this).balance;
        return int256(required) - int256(current);
    }

    receive() external payable contractIsActive {
        emit DonationReceived(msg.sender, msg.value);
    }
}
