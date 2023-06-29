Desarrollo Empresa: BLOCKCHAIN TECHNOLOGY SOLUTIONS AND ARTIFICIAL INTELLIGENCE AI S.A.S

__Nota__ La informacion que el usuario envie debe estar encriptada o el VPS, en los String para que no sea visualizada.

__Version 1.0 lanzamiento 29/06/2023 contrato 0x3cF78A2d71c1529d2EadF231e69Bc5FC645D43aA en la red Mainnet__

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
* __function AutoUser:__ Permite habilitar o deshabilitar un usuario de la red con la opcion de Booleano de vps_auto, donde True es activo y false es desactivado esto se emplea cuando el usuario pide la baja de su usuario de la red respetando las politicas de la leyes internacionales, esta funcion solo la puede realizar un usuario de mayor nivel llamado Owner o dueño del contracto 0x3cF78A2d71c1529d2EadF231e69Bc5FC645D43aA.
* __function AutoVPS:__ Permite habilitar o deshabilitar registros almacenados en la estructura VPS, se emplea cuando el vps pide la baja de su usuario de la red respetando las politicas de la leyes internacionales, o esta actuando de forma incorrecta en la red.
* __funtion createVPS:__ Permite crear nuevas empresas que administraran aplicaciones de la red Scolcoin y puede asociarse con el registro de su empresa y la Wallet del servidor.
* __funtion Modi_celular:__ Permite al usuario modifique su numero de celular ingresando su cedula o NIT.
* __funtion Modi_name:__ Permite al usuario modifique su nombre registrado en la red recuerde que todo texto String debe estar encryptado.
* __funtion Modi_VPS:__ Permite en caso de perdida del celular o del portatil o dispositivo donde tiene el metamask, cambiar con ayuda de un servidor registrado la wallet de usuario.
* __funtion Modi_WVPS:__ Permite al servidor registrado actualizar o registrar la wallet VPS tener en cuenta que el usuario puede estar registrado en otro VPS, en el momento de almacenar usuario primero hacer la consulta y verificar que la direccion este en blanco 0x0000000000000000000000000000000000000000, para poder marcarla en el caso que este ocupada por otro servidor usar el contrato 3-Wallets Usuarios.
* __funtion Modificar_all:__ Permite al usuario registrar todo los datos modificando los del inicio en scolcoin.
* __funtion Modi_User:__ Permite al usuario modificar su Nickname o apodo.
* __funtion RenounceOwner:__ Renunciar al dueño del contrato.
* __funtion transferOwner:__ Tranferir el rol de dueño de contrato.
* __funtion Consulta_VPS:__ Los servidores registrados podran consultar los datos de los usuarios con el NIT o la cedula.

__Responsabilidades:__ La empresa Blockchain Technology Diseño este contrato con el motivo que todos los usuarios sigan este mismo modelo pueden copiar este contrato o seguir el universal incluso pueden modificarlo y sugerir cambios. Recuerden siempre encryptar la informacion contenida en string y guardar una copia en sus bd locales.
