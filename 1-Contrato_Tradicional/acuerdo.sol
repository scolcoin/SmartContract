/**
@dev Acuerdo - Contrato inteligente para gestionar un acuerdo entre dos partes.
Este contrato incluye un proceso de retiro en caso de ley de retracto, y la capacidad de
verificar cláusulas y agregar trazas de proceso.
@custom:security-contact scolcoin@gmail.com
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact scolcoin@gmail.com
contract Acuerdo is Ownable {
    // Variables para almacenar información del contratista y contratante
    string  private tokenURI;
    uint private cconit_contratista;
    string private nombre_contratista;
    string private direccion_contratista;
    string private nacionalidad_contratista;
    string private pais_contratista;
    string private ciudad_contratista;    
    string private correo_contratista;
    uint private celular_contratista;            
    uint private cconit_contratante;
    string private nombre_contratante;
    string private direccion_contratante; 
    string private nacionalidad_contratante;
    string private ciudad_contratante;    
    string private pais_contratante;    
    string private correo_contratante;    
    uint private celular_contratante;       
    address public Admin;
    string private clausulas;
    bool private Admin_b=true;
    bool private Pro_b=true;
    address payable public Pro;
    bool private Auto=false;
    string private _message;  
    bool private proceadmin=false;
    bool private procepro=false;
    string [] public procesos;
    uint [] private cumplimiento;
    bytes32 private clausulas_bit;
    bool private leyretracto=false;
    bool public ley_Admin=false;
    bool public ley_Pro=false;
 
 /**
 * @dev Crea una nueva instancia del contrato Acuerdo. 
 * 
 * @param url URL del tokenURI
 * @param Administrador Dirección de la cuenta del administrador
 * @param Proveedor Dirección de la cuenta del proveedor
 * @param menkey Mensaje de clave
 */

    constructor(string memory url, address Administrador, address payable Proveedor, string memory menkey) onlyOwner {   
        tokenURI=url;
        Admin=Administrador;
        Pro=Proveedor;
        _message = menkey;
        procesos.push("0");
        cumplimiento.push(0);
    }


/**
 * @dev Deposita Scolcoin SRC-20 en el contrato.
 */
    function Deposito() public payable {}
    
/**
 * @dev Ejecuta el retiro de Scolcoin SRC-20 según el caso.
 * Si se ha invocado LeyRetiro por ambas partes, se ejecuta el retiro por ley de retracto.
 * Si no se ha invocado LeyRetiro, se requiere que la cuenta del remitente sea la cuenta del Administrador.
 * Si Auto es falso, devuelve false. 
 */
 
    function Retiro() public returns (bool Confirmar){
        //verificamos si hay ley de retracto:
        if(ley_Admin==true && ley_Pro==true){
            leyretracto=true;
                if(msg.sender==Pro && leyretracto==true){ // el Proveedor es el que ejecuta el retiro por ley de retracto
                uint total = address(this).balance;
                (bool success, ) = Admin.call{value: total}("");
                require(success, "Failed to send Ether");
                return(true);
                }
        }else{
        
                if(msg.sender==Admin && Auto==true){
                // get the amount of Ether stored in this contract
                uint total = address(this).balance;
        
                // send all Ether to owner
                // Owner can receive Ether since the address of owner is payable
                (bool success, ) = Pro.call{value: total}("");
                require(success, "Failed to send Ether");
                return(true);        
                }
                else{
                    require(Auto, "No esta Autorizado"); 
                    return(false);}    
        }
    }
     

    function LeyRetiro() public returns (bool respuesta){
        if(msg.sender==Admin){
        ley_Admin=true;
        return(true);
        }
        if(msg.sender==Pro){
        ley_Pro=true;
        return(true);
        }    
        return(false);
        
    }

    function Contratista(string memory nombre, uint ccoNit, string memory nacionalidad, string memory direccion, string memory pais, string memory ciudad, string memory email, uint celular) public returns (bool Confirmar) {
        if(msg.sender==Admin && Admin_b==true){
            nombre_contratista=nombre;
            cconit_contratista=ccoNit;
            direccion_contratista=direccion;
            nacionalidad_contratista=nacionalidad;
            pais_contratista=pais;
            ciudad_contratista=ciudad;
            correo_contratista=email;
            celular_contratista=celular;
            return(true);
        }        
    }  

    function Contratante(string memory Nombre, uint CCoNit, string memory Nacionalidad, string memory Direccion, string memory Pais, string memory Ciudad, string memory Email, uint Celular) public returns (bool Confirmar){
        if(msg.sender==Pro && Pro_b==true){
            cconit_contratante=CCoNit;
            nombre_contratante=Nombre;
            direccion_contratante=Direccion; 
            nacionalidad_contratante=Nacionalidad;
            ciudad_contratante=Ciudad;    
            pais_contratante=Pais;    
            correo_contratante=Email;    
            celular_contratante=Celular; 
            return(true);
        }       
    } 

    function Clausulas(string memory Acuerdos) public onlyOwner{  
            clausulas=Acuerdos;
            clausulas_bit=keccak256(abi.encodePacked(clausulas,Admin));    
    }

    function Traza (string memory Traz) public onlyOwner{ 
        procesos.push(Traz);
        cumplimiento.push(0);
    }

    // verificador
    function AllClausulas( string memory Clausula) public view returns (bool Verificacion, string memory Texto) {
    bool Confir=false;
    bytes32 compara=keccak256(abi.encodePacked(Clausula,Admin));
   
    // encriptamos

    if(clausulas_bit==compara){
        Confir=true;
    }

    return (Confir, clausulas);
    } 

       function Hash() public view returns (bytes32 F) {
        if(msg.sender==Admin || msg.sender==Pro){
            return (clausulas_bit);        
        }
    }

    function Firma_admin(string memory key) public view returns (bytes32 F) {
        if(msg.sender==Admin && Admin_b==true){
            address _to = Pro;
            uint _amount=1; 
            uint    _nonce=1;
            Admin_b==false;
            return keccak256(abi.encodePacked(_to, _amount, key, _nonce));        
        }
    }

    function Firma_Provee(string memory keypro) public view returns (bytes32 F) {
        if(msg.sender==Pro && Pro_b==true){
        Pro_b==false;
            address _to = Pro;
            uint _amount=1;

            uint    _nonce=1;
            return keccak256(abi.encodePacked(_to, _amount, keypro, _nonce));            
        }
    }

 

    function Verify(bytes32 Firma) public view returns (bool) {

        if(msg.sender==Admin && Admin_b==false){
            address _to = Pro;
            uint _amount=1;          
            uint    _nonce=1;
            bytes32 vfirmaadmin= keccak256(abi.encodePacked(_to, _amount, _message, _nonce)); 
                    if(Firma == vfirmaadmin){
                        proceadmin==true;
                        return(true);
                    }       
        }
        if(msg.sender==Pro && Pro_b==false){
            address _to = Pro;
            uint _amount=1;
            uint    _nonce=1;
            bytes32 vfirmapro= keccak256(abi.encodePacked(_to, _amount, _message, _nonce));  
                    if(Firma == vfirmapro){
                        procepro==true;
                        return(true);
                    }                       
        }

        return(false);
    }

  function Trazabilidad(uint num_t, uint Op) public view {
      // num_t es el proceso y su calificacion.
      if(msg.sender==Admin && Admin_b==false){
            if (Op == 1) {
            // Si
            cumplimiento[num_t]==1;
            } 
            else if (Op == 2) 
            {
            // No
            cumplimiento[num_t]==2;
            } else {
            revert();
            }
      }
  }
  
  function Auditoria (uint num_t) public view returns (string memory Proceso, uint Resultado){
      // trae proceso y Resultado
    return(procesos[num_t],cumplimiento[num_t]);
  }

  function Ejecucion () public view returns (bool){
      if(msg.sender==Admin && Admin_b==false){
      Auto==true;
      return (true);
      }
      return (false);

  }

   /*
    * Nota: Marco Legal Internacional del Smart Contract
    */

   // El smart contract se compone de dos partes, el contrato redactado en lenguaje natural y es el que debemos de tener de forma previa para evitar problemas y amacenado en un Uri en IPFS, y la parte digital, que no es un contrato en sí, sino una programación informática basada en las condiciones del contrato legal (STS, 31 marzo de 2011, nº 217/2011) Link texto: https://evahernandezramos.com/smart-contract-que-requisitos-tiene-que-tener/

    /*
    * Marco Legal Colombia - Ley 527 de 1999
    */
   // https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=4276
   
}
