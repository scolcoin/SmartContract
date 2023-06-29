/** optimizacion 5000 y solidity ^0.8.0
@dev Usuario - Contrato inteligente para gestionar usuarios de la red Scolcoin.
Este contrato incluye informacion basica de cada individuo de forma universal (encryptado), En el Array encontramos variables modificables.
@custom:security-contact blockchaintechnologysas@gmail.com
ANN: esta plantilla es publica hace parte del universo BLOCKCHAIN TECHNOLOGY y la puede adoptar cualquier desarrollador
Empresa: BLOCKCHAIN TECHNOLOGY SOLUTIONS AND ARTIFICIAL INTELLIGENCE AI S.A.S*/
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";


contract Usuarios is Ownable {

    struct User {
        uint id;
        string nombre;
        uint ccoNit;
        string email;
        uint indicativo;
        uint celular;
        string nickname;
        address wallet;
        address wallet_vps;
        bool user_auto;
    }

    // VPS Autorizados
    struct VPS {
        uint Id;
        address vps;
        string  empresa;
        bool    vps_auto;
    }

    User[] private users;
    VPS[] private vpsList;
    uint numusuario;
    uint totalvps;


/**
 * @dev Crea una nueva instancia del contrato Usuario. 
 * 
 * Nombre (Tipo= Constante)
 * Identificacion Cedula (Numero de Identificacion Ciudadana) (Tipo= Constante)
 * Email (Tipo= variable)
 * Indicativo Pais (Tipo= variable)
 * Celular (Tipo= variable)
 * Usuario (Tipo= variable)
 */

    constructor() onlyOwner { 
    }


    function addUser(
        string memory _nombre,
        uint _ccoNit,
        string memory _email,
        uint _indicativo,
        uint _celular,
        string memory _nickname,
        address _wallet
    ) public returns (uint userID){
        require(bytes(_nombre).length > 0, "Nombre is required");
        require(_ccoNit > 0, "CCoNit must be greater than 0");
        require(bytes(_email).length > 0, "Email is required");
        require(validateEmail(_email), "Invalid email format");
        require(_indicativo > 0, "Indicativo is required");
        require(_celular > 0, "Celular is required");
        require(bytes(_nickname).length > 0, "User is required");
        require(_wallet != address(0), "Wallet address is required");
        
        //validaciones:
        require(checknom(_nombre), "Nombre duplicada"); 
        require(check_cconit(_ccoNit), "CC o NIT duplicada");   
        require(check_email(_email), "Email duplicada"); 
        require(check_celular(_celular), "Celular duplicada"); 
        require(checknick(_nickname), "Usuario duplicada");        
        require(check_wallet(_wallet), "Wallet duplicada");

        

        userID = numusuario++; // userID es variable de retorno
        
        User memory newUser = User(
            userID,
            _nombre,
            _ccoNit,
            _email,
            _indicativo,
            _celular,
            _nickname,
            _wallet,
            0x0000000000000000000000000000000000000000,
            true
        );

        users.push(newUser);
    }

// Buscamos Usuario y nos devuelve el ID

    function findcconit(
        uint _ccoNit
    ) private view returns (uint) {
        for (uint i = 0; i < users.length; i++) {
            User memory user = users[i];
            if (
                (
                    user.ccoNit == _ccoNit
                ) && user.user_auto ==true
            ) {
                return user.id;
            }
        }
        revert("Usuario no encontrado");
        
    }

    // busqueda de usuario por cedula trae el ID
     function findcconit_vps(
        uint _ccoNit
    ) private view returns (uint) {
        for (uint i = 0; i < users.length; i++) {
            User memory user = users[i];
            if (
                (
                    user.ccoNit == _ccoNit
                ) && user.user_auto ==true
            ) {
                return user.id;
            }
        }
        //revert("Usuario no encontrado");
        return 0;
    }   

    // busqueda de usuario y nos trae wallet
      function findcconit_wallet(
        uint _ccoNit
    ) private view returns (address) {
        for (uint i = 0; i < users.length; i++) {
            User memory user = users[i];
            if (
                (
                    user.ccoNit == _ccoNit
                ) && user.user_auto ==true
            ) {
                return user.wallet;
            }
        }
        revert("Usuario no encontrado");
        
    }   

// comparamos Email
     function validateEmail(string memory email) private pure returns (bool) {
        bytes memory emailBytes = bytes(email);
        bool containsAtSymbol = false;
        
        // Verificar si el correo electrónico contiene un solo símbolo '@'
        for (uint i = 0; i < emailBytes.length; i++) {
            if (emailBytes[i] == '@') {
                if (containsAtSymbol) {
                    return false; // El correo electrónico contiene más de un símbolo '@'
                }
                containsAtSymbol = true;
            }
        }
        
        // Verificar si el correo electrónico tiene al menos un caracter antes y después del '@'
        if (!containsAtSymbol || emailBytes[0] == '@' || emailBytes[emailBytes.length - 1] == '@') {
            return false;
        }
        
        return true;
    }

//validacion Nombre
   function checknom(
        string memory _nombre
    ) internal view returns (bool) {
        for (uint i = 0; i < users.length; i++) {
            User memory user = users[i];
            if (
                keccak256(bytes(user.nombre)) == keccak256(bytes(_nombre)) 
            ) {
                return false; // Usuario duplicado
            }
        }
        return true; // Usuario único
    }

   function check_cconit(
        uint _ccoNit
    ) internal view returns (bool) {
        for (uint i = 0; i < users.length; i++) {
            User memory user = users[i];
            if (
                user.ccoNit == _ccoNit 
            ) {
                return false; // Usuario duplicado
            }
        }
        return true; // Usuario único
    }

// validamos email
   function check_email(
        string memory _email
    ) internal view returns (bool) {
        for (uint i = 0; i < users.length; i++) {
            User memory user = users[i];
            if (
                keccak256(bytes(user.email)) == keccak256(bytes(_email)) 
            ) {
                return false; // Usuario duplicado
            }
        }
        return true; // Usuario único
    }

// validamos celular
  function check_celular(
        uint _celular
    ) internal view returns (bool) {
        for (uint i = 0; i < users.length; i++) {
            User memory user = users[i];
            if (
                user.celular == _celular 
            ) {
                return false; // Usuario duplicado
            }
        }
        return true; // Usuario único
    }


    function checknick(
        string memory _nickname
    ) internal view returns (bool) {
        for (uint i = 0; i < users.length; i++) {
            User memory user = users[i];
            if (
                keccak256(bytes(user.nickname)) == keccak256(bytes(_nickname)) 
            ) {
                return false; // Usuario duplicado
            }
        }
        return true; // Usuario único
    }

/*
    function checkUniqueness(
        string memory _nombre,
        uint _ccoNit,
        string memory _nickname,
        address _wallet,
        address _wallet_vps,
        string memory _email,
        uint _celular
    ) internal view returns (bool) {
        for (uint i = 0; i < users.length; i++) {
            User memory user = users[i];
            if (
                keccak256(bytes(user.nombre)) == keccak256(bytes(_nombre)) ||
                user.ccoNit == _ccoNit ||
                keccak256(bytes(user.nickname)) == keccak256(bytes(_nickname)) ||
                user.wallet == _wallet ||
                user.wallet_vps == _wallet_vps ||
                keccak256(bytes(user.email)) == keccak256(bytes(_email)) ||
                user.celular == _celular 
            ) {
                return false; // Usuario duplicado
            }
        }
        return true; // Usuario único
    }
*/
// walletVPS
   function check_wallet(
        address _wallet
    ) internal view returns (bool) {
        for (uint i = 0; i < users.length; i++) {
            User memory user = users[i];
            if (
                user.wallet == _wallet 
            ) {
                return false; // Usuario duplicado
            }
        }
        return true; // Usuario único
    }

// walletVPS
   function check_walletvps(
        address _wallet_vps
    ) internal view returns (bool) {
        for (uint i = 0; i < users.length; i++) {
            User memory user = users[i];
            if (
                user.wallet_vps == _wallet_vps 
            ) {
                return false; // Usuario duplicado
            }
        }
        return true; // Usuario único
    }

//buscar VPS Wallet
function checkUVPS(address _vps) internal view returns (bool) {
        for (uint i = 0; i < vpsList.length; i++) {
            VPS memory vpsd = vpsList[i];
            if (
                vpsd.vps == _vps
            ) {
                return false; // Usuario duplicado
            }
        }
        return true; // Usuario único
    }

//buscar VPS Usuario
function findUVPS(address _vps) private view returns (uint) {
        for (uint i = 0; i < vpsList.length; i++) {
            VPS memory vps = vpsList[i];
            
                if (vps.vps == _vps) {
                    return vps.Id;
                }
            
        }
        revert("Usuario no encontrado");
    }  

 //verificar VPS valido
function valUVPS(uint _nu) private view returns (bool) {
        
            VPS memory vps = vpsList[_nu];
            
                if (vps.vps_auto == true) {
                    return true;
                }
            
        
        return false;
    }      

 // VPS
  function createVPS(
        address _vps,
        string memory _empresa
    ) public onlyOwner {   
        uint userID = totalvps++; // userID es variable de retorno
        require(_vps != address(0), "VPS address is required");
        //validaciones:
       require(checkUVPS(_vps), "Usuario duplicado");

        VPS memory newVPS = VPS(userID, _vps, _empresa, true);

        vpsList.push(newVPS);
        
    } 

// Add User VPS
    function AddUserVPS(address _wallet_vps, string memory _nombre, uint _ccoNit, string memory _email, uint _indicativo, uint _celular, string memory _nickname) public returns (uint userID) {
        address userAddress = msg.sender;
        uint idusu=0;
        uint idvps=0;
        //requiere
        require(bytes(_nombre).length > 0, "Nombre is required");
        require(_ccoNit > 0, "CCoNit must be greater than 0");
        require(bytes(_email).length > 0, "Email is required");
        require(validateEmail(_email), "Invalid email format");
        require(_indicativo > 0, "Indicativo is required");
        require(_celular > 0, "Celular is required");
        require(bytes(_nickname).length > 0, "User is required");
        require(_wallet_vps != address(0), "Wallet address is required");

        //validacion check_walletvps
        require(check_walletvps(_wallet_vps), "Wallet VPS duplicada");

        //busqueda
        idusu=findcconit_vps(_ccoNit);
        idvps=findUVPS(userAddress);

             //1- condicion VPS si existe siga
        if(!checkUVPS(userAddress)){
            // 2- condicion VPS Autorizado siga
            if(valUVPS(idvps)){
            // 3- Condicion Usuario Existe siga modifique    
                if(idusu>=1){
                    // modificamos usuario:
                    m_usu_cc(_ccoNit,_wallet_vps);
                }
                //sino cree
                else{
                        //Validamos
                        //validaciones:
                        require(checknom(_nombre), "Nombre duplicada"); 
                        require(check_cconit(_ccoNit), "CC o NIT duplicada");   
                        require(check_email(_email), "Email duplicada"); 
                        require(check_celular(_celular), "Celular duplicada"); 
                        require(checknick(_nickname), "Usuario duplicada");        
                        require(check_walletvps(_wallet_vps), "Wallet duplicada");

                        //ID
                        userID = numusuario++; // userID es variable de retorno
                        User memory newUser = User(
                            userID,
                            _nombre,
                            _ccoNit,
                            _email,
                            _indicativo,
                            _celular,
                            _nickname,
                            0x0000000000000000000000000000000000000000,
                            _wallet_vps,
                            true
                        );

                        users.push(newUser);
                }
            }
        }
    }

// modifica usuario desde VPS:
function m_usu_cc(uint _ccoNit, address _newWalletVPS) private {
        for (uint i = 0; i < users.length; i++) {
            User storage user = users[i];
            if (user.ccoNit == _ccoNit) {
                user.wallet_vps = _newWalletVPS;
                return;
            }
        }
        revert("Usuario no encontrado");
    }  

    //Autorizar VPS o Negar
    function AutoVPS(address _vps, bool _permiso) public onlyOwner {
        uint nvid= findUVPS(_vps);
        require(vpsList.length > 1, "No hay suficientes datos");

        vpsList[nvid].vps_auto = _permiso;
    }

  // Autorizar Usuario
    function AutoUser(uint _ccoNit, bool _permiso) public onlyOwner {
        uint nvid= findcconit_vps(_ccoNit);
        require(users.length > 1, "No hay suficientes datos");

        users[nvid].user_auto = _permiso;
    }

    // ver datos solo los VPS
    function Consulta_VPS(  
        uint _ccoNit
        ) public view returns (
            uint    Id,
            string memory  Nombres,
            uint    CCoNit,
            string memory  Email,
            uint    Indicativo,
            uint    Celular,
            string  memory _Nickname,
            address Wallet,
            address Wallet_vps,
            bool    User_auto  
        ){
            require(_ccoNit > 0, "CCoNit must be greater than 0");
              // wallet VPS
              address userAddress = msg.sender;
              //traemos posicion
              uint idusu=findcconit_vps(_ccoNit);
              uint idvps=findUVPS(userAddress);
              

                    //1- condicion VPS si existe siga
                if(!checkUVPS(userAddress)){
                    // 2- condicion VPS Autorizado siga
                    if(valUVPS(idvps)){
                    // 3- Condicion Usuario Existe siga modifique    
                        if(idusu>=1){
                            // modificamos usuario:
                        require(users.length > 1, "No hay suficientes datos");
                        return(
                            users[idusu].id,
                            users[idusu].nombre,
                            users[idusu].ccoNit,
                            users[idusu].email,
                            users[idusu].indicativo,
                            users[idusu].celular,
                            users[idusu].nickname,
                            users[idusu].wallet,
                            users[idusu].wallet_vps,
                            users[idusu].user_auto
                        );
                }}}

        }    


      // Modificar Usuario Datos Variables
    function Modificar_all(  
        uint _ccoNit,      
        string memory _nombre,
        string memory _email,
        uint _indicativo,
        uint _celular,
        string memory _nickname
        ) public {
        //variables locales
        address localwallet;    
        //Requiere    
        require(bytes(_nombre).length > 0, "Nombre is required");
        require(bytes(_email).length > 0, "Email is required");
        require(validateEmail(_email), "Invalid email format");
        require(_indicativo > 0, "Indicativo is required");
        require(_celular > 0, "Celular is required");
        require(bytes(_nickname).length > 0, "User is required");
        require(_ccoNit > 0, "CCoNit must be greater than 0");
        // wallet usuario
        address userAddress = msg.sender;
        //traemos posicion
        uint nvid= findcconit_vps(_ccoNit);
        require(users.length > 1, "No hay suficientes datos");
        //validar con la captura de la wallet userAddress para verificar que sea el dueño
        localwallet=findcconit_wallet(_ccoNit);
        //1- Condicion si wallet capturada y extraida son iguales siga
        if(localwallet==userAddress){
             // modificamos
             require(users.length > 1, "No hay suficientes datos");
             users[nvid].nombre = _nombre;
             users[nvid].email = _email;
             users[nvid].indicativo = _indicativo;
             users[nvid].celular = _celular;
             users[nvid].nickname = _nickname;            
        }
        
    }

      // Modificar Usuario Datos Variables
    function Modi_name(  
        uint _ccoNit,      
        string memory _nombre
        ) public {
        //variables locales
        address localwallet;    
        //Requiere    
        require(bytes(_nombre).length > 0, "Nombre is required");
        require(_ccoNit > 0, "CCoNit must be greater than 0");
        // wallet usuario
        address userAddress = msg.sender;
        //traemos posicion
        uint nvid= findcconit_vps(_ccoNit);
        require(users.length > 1, "No hay suficientes datos");
        //validar con la captura de la wallet userAddress para verificar que sea el dueño
        localwallet=findcconit_wallet(_ccoNit);
        //1- Condicion si wallet capturada y extraida son iguales siga
        if(localwallet==userAddress){
             // modificamos
             require(users.length > 1, "No hay suficientes datos");
             users[nvid].nombre = _nombre;          
        }
        
    }

// Modificar Usuario Datos Variables
    function Modi_celular(  
        uint _ccoNit,      
        uint _indicativo,
        uint _celular
        ) public {
        //variables locales
        address localwallet;    
        //Requiere    
        require(_indicativo > 0, "Indicativo is required");
        require(_celular > 0, "Celular is required");
        require(_ccoNit > 0, "CCoNit must be greater than 0");
        // wallet usuario
        address userAddress = msg.sender;
        //traemos posicion
        uint nvid= findcconit_vps(_ccoNit);
        require(users.length > 1, "No hay suficientes datos");
        //validar con la captura de la wallet userAddress para verificar que sea el dueño
        localwallet=findcconit_wallet(_ccoNit);
        //1- Condicion si wallet capturada y extraida son iguales siga
        if(localwallet==userAddress){
             // modificamos
             require(users.length > 1, "No hay suficientes datos");
             users[nvid].indicativo = _indicativo;
             users[nvid].celular = _celular;           
        }
        
    }

// Modificar Usuario Datos Variables
    function ModiUser(  
        uint _ccoNit,      
        string memory _nickname
        ) public {
        //variables locales
        address localwallet;    
        //Requiere    
        require(bytes(_nickname).length > 0, "User is required");
        require(_ccoNit > 0, "CCoNit must be greater than 0");
        // wallet usuario
        address userAddress = msg.sender;
        //traemos posicion
        uint nvid= findcconit_vps(_ccoNit);
        require(users.length > 1, "No hay suficientes datos");
        //validar con la captura de la wallet userAddress para verificar que sea el dueño
        localwallet=findcconit_wallet(_ccoNit);
        //1- Condicion si wallet capturada y extraida son iguales siga
        if(localwallet==userAddress){
             // modificamos
             require(users.length > 1, "No hay suficientes datos");
             users[nvid].nickname = _nickname;            
        }
        
    }

 // Modificar Usuario Wallet por medio del Servidor VPS

function Modi_VPS(  
        uint _ccoNit,
        address nuevawallet
         ) public {   
              address userAddress = msg.sender;
              require(nuevawallet != address(0), "Wallet address is required"); 
              require(_ccoNit > 0, "CCoNit must be greater than 0");
              //traemos posicion
              uint idusu=findcconit_vps(_ccoNit);
              uint idvps=findUVPS(userAddress);
        

                    //1- condicion VPS si existe siga
                if(!checkUVPS(userAddress)){
                    // 2- condicion VPS Autorizado siga
                    if(valUVPS(idvps)){
                    // 3- Condicion Usuario Existe siga modifique    
                        if(idusu>=1){
                            // modificamos usuario:
                        require(users.length > 1, "No hay suficientes datos");
                        users[idusu].wallet = nuevawallet;
                }}}
         
         }

// Modificar Usuario Wallet VPS

function Modi_WVPS(  
        uint _ccoNit,
        address nuevawallet_VPS
         ) public {   
              address userAddress = msg.sender;
              require(nuevawallet_VPS != address(0), "Wallet address is required"); 
              require(_ccoNit > 0, "CCoNit must be greater than 0");
              //traemos posicion
              uint idusu=findcconit_vps(_ccoNit);
              uint idvps=findUVPS(userAddress);
        

                    //1- condicion VPS si existe siga
                if(!checkUVPS(userAddress)){
                    // 2- condicion VPS Autorizado siga
                    if(valUVPS(idvps)){
                    // 3- Condicion Usuario Existe siga modifique    
                        if(idusu>=1){
                            // modificamos usuario:
                        require(users.length > 1, "No hay suficientes datos");
                        users[idusu].wallet_vps = nuevawallet_VPS;
                }}}
         
         }

}