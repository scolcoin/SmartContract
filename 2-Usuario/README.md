Desarrollo Empresa: BLOCKCHAIN TECHNOLOGY SOLUTIONS AND ARTIFICIAL INTELLIGENCE AI S.A.S

__Version 1.0 lanzamiento 29/06/2023 contrato 0x3773F1B6D5B410d1eb7E787C3772DD8F34268F1B en la red Mainnet__

Este contrato de Solidity es un contrato inteligente para gestionar usuarios de una red llamada Scolcoin. Proporciona una estructura de datos para almacenar información básica de cada usuario de forma universal y encriptada. El contrato incluye una lista de usuarios y una lista de VPS (Servidores Privados Virtuales) autorizados.

El contrato utiliza la versión de Solidity ^0.8.0 y tiene una optimización establecida en 5000. Además, el contrato importa la biblioteca "Ownable" del paquete "@openzeppelin/contracts/access/Ownable.sol", que proporciona funcionalidades para establecer y gestionar el propietario del contrato.

# El contrato tiene la siguiente estructura de datos:

### Struct "User": Representa a un usuario y contiene los siguientes campos:

* "id": Identificador único del usuario.
* "nombre": Nombre del usuario.
* "ccoNit": Número de identificación ciudadana o NIT del usuario.
* "email": Dirección de correo electrónico del usuario.
* "indicativo": Indicativo del país del usuario.
* "celular": Número de celular del usuario.
* "nickname": Nombre de usuario del usuario.
* "wallet": Dirección de la billetera del usuario.
* "wallet_vps": Dirección de la billetera VPS del usuario.
* "user_auto": Indicador de autorización del usuario.

### Struct "VPS": Representa un VPS autorizado y contiene los siguientes campos:

* "Id": Identificador único del VPS.
* "vps": Dirección del VPS.
* "empresa": Nombre de la empresa asociada al VPS.
* "vps_auto": Indicador de autorización del VPS.

El contrato también incluye dos listas privadas: "users" y "vpsList". Estas listas almacenan los usuarios y los VPS respectivamente. Además, hay variables "numusuario" y "totalvps" que se utilizan para generar identificadores únicos para los usuarios y los VPS.

El contrato tiene una función constructora que se ejecuta al desplegar el contrato y es accesible solo por el propietario del contrato (función "onlyOwner"). No se realiza ninguna operación dentro de la función constructora en este caso.

El contrato incluye varias funciones públicas para interactuar con los usuarios y los VPS. Algunas de las funciones principales son las siguientes:
* __function AddUser:__ Permite agregar un nuevo usuario a la lista de usuarios. Se deben proporcionar los datos del usuario como parámetros, incluyendo el nombre, el ccoNit, el email, el indicativo, el celular, el nickname y la dirección de la billetera. Antes de agregar al usuario, se realizan varias validaciones para asegurar que los datos sean correctos y únicos.
* __function AddUserVPS:__ Permite a los servidores VPS registrados almacenar usuarios de sus aplicaciones para tener un solo registro del universo Scolcoin.
* __function AutoUser:__ Permite habilitar o deshabilitar un usuario de la red con la opcion de Booleano de vps_auto, donde True es activo y false es desactivado esto se emplea cuando el usuario pide la baja de su usuario de la red respetando las politicas de la leyes internacionales, esta funcion solo la puede realizar un usuario de mayor nivel llamado Owner o dueño del contracto 0x3773F1B6D5B410d1eb7E787C3772DD8F34268F1B.
* __function AutoVPS:__ Permite habilitar o deshabilitar registros almacenados en la estructura VPS, se emplea cuando el vps pide la baja de su usuario de la red respetando las politicas de la leyes internacionales, o esta actuando de forma incorrecta en la red.
* __funtion createVPS:__ Permite crear nuevas empresas que administraran aplicaciones de la red Scolcoin y puede asociarse con el registro de su empresa y la Wallet del servidor.
* 
