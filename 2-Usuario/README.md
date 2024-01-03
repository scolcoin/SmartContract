Desarrollo Empresa: BLOCKCHAIN TECHNOLOGY SOLUTIONS AND ARTIFICIAL INTELLIGENCE AI S.A.S

__Nota__ La informacion que el usuario envie debe estar encriptada en el VPS.

__Version 2.0 lanzamiento 03/01/2024 contrato 0x3cF78A2d71c1529d2EadF231e69Bc5FC645D43aA en la red Mainnet__

Este contrato de Solidity es un contrato inteligente para gestionar usuarios de una red llamada Scolcoin. Proporciona una estructura de datos para almacenar información básica de cada usuario de forma universal y encriptada. El contrato incluye una lista de usuarios y una lista de VPS (Servidores Privados Virtuales) autorizados.

El contrato utiliza la versión de Solidity ^0.8.7 y tiene una optimización establecida en 5000. Además, el contrato importa la biblioteca "Ownable" del paquete "@openzeppelin/contracts/access/Ownable.sol", que proporciona funcionalidades para establecer y gestionar el propietario del contrato.

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
Este contrato gestiona la información de los usuarios y su interacción con el contrato VPS.

### Estructuras:
* User: Almacena la información de cada usuario, incluyendo su ID, nombre, CCoNit, dirección de billetera, entre otros.
* Variables de Estado:
* vpsContract: Instancia del contrato VPS utilizado para interactuar con las funciones relacionadas con VPS.
* users: Array privado que almacena la información de todos los usuarios.
* numusuario: Número total de usuarios registrados.

### Eventos:
* UsuarioModificado: Evento emitido cuando se modifica la billetera VPS de un usuario.
* Funciones Principales:
* constructor: Inicializa el contrato y establece la dirección del contrato VPS.
* setVPSContract: Permite al propietario cambiar la dirección del contrato VPS.
* addUserVPS: Agrega un nuevo usuario y crea su correspondiente VPS a través del contrato VPS.
* modifyWalletVPS: Modifica la billetera VPS de un usuario.

### Funciones Internas:
* findCcoNit: Busca a un usuario por su CCoNit.
* VPS.sol
* Descripción: Este contrato gestiona la información de los VPS y su relación con los usuarios.

### Estructuras:
* VPSData: Almacena la información de cada VPS, incluyendo su ID, dirección, empresa y estado de auto.

### Variables de Estado:
* usuariosContract: Instancia del contrato Usuarios utilizado para interactuar con las funciones relacionadas con usuarios.
* vpsList: Array privado que almacena la información de todos los VPS creados.
* totalVPS: Número total de VPS registrados.

### Funciones Principales:
* constructor: Inicializa el contrato y establece la dirección del contrato Usuarios.
* createVPS: Crea un nuevo VPS y lo asocia a un usuario a través del contrato Usuarios.
* findUVPS: Busca un VPS por su dirección.
* modifyWalletVPS: Modifica la dirección de billetera de un VPS.

El contrato también incluye dos listas privadas: "users" y "vpsList". Estas listas almacenan los usuarios y los VPS respectivamente. Además, hay variables "numusuario" y "totalvps" que se utilizan para generar identificadores únicos para los usuarios y los VPS.

El contrato tiene una función constructora que se ejecuta al desplegar el contrato y es accesible solo por el propietario del contrato (función "onlyOwner"). No se realiza ninguna operación dentro de la función constructora en este caso.

El contrato incluye varias funciones públicas para interactuar con los usuarios y los VPS. Algunas de las funciones principales son las siguientes:


__Responsabilidades:__ La empresa Blockchain Technology Diseño este contrato con el motivo que todos los usuarios sigan este mismo modelo pueden copiar este contrato o seguir el universal incluso pueden modificarlo y sugerir cambios. Recuerden siempre encryptar la informacion contenida en string y guardar una copia en sus bd locales.
