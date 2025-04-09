# Gestion Precio
El Contrato Precios es un modelo para manejan las metricas de los token y los precio del exchange, p2p, metaverso, etc.

el precio de maneja en centavos en cualquier valor esto con el objetivo de tener hasta dos decimales de las monedas internacionales.

Por ejemplo, si estás tratando con dólares y 10 decimales, puedes representar 1 dólar como 10000000000. Entonces, si deseas representar $1.50, lo representarías como 15000000000.

la Wallet de SCOL como nativa es: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE

## Contrato Lista de Precios

- Contract Address: 0x55E4aB3822e435412cc094b947d478A1272961c9
- Contract Name: ListaDePrecios
- Compiler: v0.8.7+commit.e28d00a7
- Optimization: Yes
- Optimization runs: 5000
- ABI-encoded Constructor Arguments (if required by the contract):

[
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_nombre",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "_cop",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_usd",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_jpy",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_pen",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_eur",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_brl",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_btc",
				"type": "uint256"
			}
		],
		"name": "actualizarPrecio",
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
				"internalType": "uint256",
				"name": "_cop",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_usd",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_jpy",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_pen",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_eur",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_brl",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_btc",
				"type": "uint256"
			}
		],
		"name": "agregarPrecio",
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
				"name": "",
				"type": "string"
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
				"name": "_nuevoPropietario",
				"type": "address"
			}
		],
		"name": "transferirPropiedad",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
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
				"name": "",
				"type": "string"
			}
		],
		"name": "precios",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "cop",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "usd",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "jpy",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "pen",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "eur",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "brl",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "btc",
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
				"name": "",
				"type": "address"
			}
		],
		"name": "vpsAutorizados",
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

https://explorer.scolcoin.com/address/0x55E4aB3822e435412cc094b947d478A1272961c9/contracts
