Desarrollo Empresa: BLOCKCHAIN TECHNOLOGY SOLUTIONS AND ARTIFICIAL INTELLIGENCE AI S.A.S

__Nota__ La informacion que el usuario envie debe estar encriptada en el VPS.

__Version 2.0 lanzamiento 25/01/2024__
* Usuarios.sol contrato __0xf19453929c3C4AE735D3fd85ece410cc2acF650f__ 

__en la red Mainnet__

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

__ABI:__
[
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_nombre",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_ccoNit",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_email",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_indicativo",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_celular",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_nickname",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "_wallet",
				"type": "address"
			},
			{
				"internalType": "bool",
				"name": "_user_auto",
				"type": "bool"
			}
		],
		"name": "agregarUsuario",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_vps",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "_empresa",
				"type": "string"
			},
			{
				"internalType": "bool",
				"name": "_vps_auto",
				"type": "bool"
			}
		],
		"name": "agregarVPS",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_usuario",
				"type": "address"
			},
			{
				"internalType": "bool",
				"name": "nuevoEstadoAutoUsuario",
				"type": "bool"
			}
		],
		"name": "modificarEstadoAutoUsuario",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_vps",
				"type": "address"
			},
			{
				"internalType": "bool",
				"name": "nuevoEstadoAutoVPS",
				"type": "bool"
			}
		],
		"name": "modificarEstadoAutoVPS",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_nombre",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_ccoNit",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_email",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_indicativo",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_celular",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_nickname",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "_wallet",
				"type": "address"
			}
		],
		"name": "modificarUsuario",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_usuario",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "nuevaWallet",
				"type": "address"
			}
		],
		"name": "modificarWalletUsuario",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_vps",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "nuevaWalletVPS",
				"type": "address"
			}
		],
		"name": "modificarWalletVPS",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "previousOwner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "OwnershipTransferred",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "renounceOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bool",
				"name": "existe",
				"type": "bool"
			}
		],
		"name": "UsuarioExistente",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bool",
				"name": "existe",
				"type": "bool"
			}
		],
		"name": "UsuarioExistentePorCcoNit",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bool",
				"name": "existe",
				"type": "bool"
			}
		],
		"name": "UsuarioExistentePorEmail",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bool",
				"name": "existe",
				"type": "bool"
			}
		],
		"name": "UsuarioExistentePorNickname",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "vps",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "address",
				"name": "nuevaWalletVPS",
				"type": "address"
			}
		],
		"name": "UsuarioModificado",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "verificarYEnviarEventos",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_wallet",
				"type": "address"
			}
		],
		"name": "encontrarUsuario",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_vpsAddress",
				"type": "address"
			}
		],
		"name": "isVPS",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "numusuario",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_userId",
				"type": "uint256"
			}
		],
		"name": "obtenerDatosUsuarioPorId",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "nombre",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "ccoNit",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "email",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "indicativo",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "celular",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "nickname",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "wallet",
						"type": "address"
					},
					{
						"internalType": "bool",
						"name": "user_auto",
						"type": "bool"
					}
				],
				"internalType": "struct Usuarios.Usuario",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_vpsWallet",
				"type": "address"
			}
		],
		"name": "obtenerNombreVPSPorWallet",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_userId",
				"type": "uint256"
			}
		],
		"name": "obtenerUsuario",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "nombre",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "ccoNit",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "email",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "indicativo",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "celular",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "nickname",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "wallet",
						"type": "address"
					},
					{
						"internalType": "bool",
						"name": "user_auto",
						"type": "bool"
					}
				],
				"internalType": "struct Usuarios.Usuario",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_ccoNit",
				"type": "string"
			}
		],
		"name": "usuarioExistePorCcoNit",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_email",
				"type": "string"
			}
		],
		"name": "usuarioExistePorEmail",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_userId",
				"type": "uint256"
			}
		],
		"name": "usuarioExistePorId",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_nickname",
				"type": "string"
			}
		],
		"name": "usuarioExistePorNickname",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_wallet",
				"type": "address"
			}
		],
		"name": "usuarioExistePorWallet",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_vps",
				"type": "address"
			}
		],
		"name": "vpsExistePorWallet",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]

