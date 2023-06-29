Desarrollo Empresa: BLOCKCHAIN TECHNOLOGY SOLUTIONS AND ARTIFICIAL INTELLIGENCE AI S.A.S

__Nota:__ Este contrato es una continuacion del modelo usuario universal 2-Usuario.

_Version 1.0 lanzamiento 29/06/2023 contrato 0x9c6311b7F3636f5d9354fFf519baD50080747d41 en la red Mainnet_


El contrato "Wallets" es un contrato inteligente diseñado para gestionar las wallets de los usuarios registrados en la red Scolcoin. Este contrato permite crear y consultar wallets asociadas a usuarios, así como autorizar y gestionar VPS (Servidores Privados Virtuales) relacionados con las wallets.


El contrato incluye dos estructuras: "Wallet" y "VPS". La estructura "Wallet" contiene el ID del usuario, el ID del VPS asociado y la dirección de la wallet. La estructura "VPS" almacena la dirección del VPS y un indicador de autorización.

### El contrato cuenta con las siguientes funciones principales:

* __createWallet(uint _id_usu, address _wallet_otra)__: Esta función permite crear una nueva wallet para un usuario. Se requiere el ID del usuario y la dirección de la wallet. Solo se permite la creación de una wallet si el VPS asociado a la transacción está autorizado.
* __Cons_id(uint _id_usu)__: Esta función permite consultar la wallet de un usuario por su ID. Devuelve el ID del usuario consultado, la cantidad de wallets encontradas y un array de direcciones de wallets asociadas al usuario. Solo se muestra la información si el VPS asociado a la transacción está autorizado.
* __createVPS(address _vps)__: Esta función permite crear un nuevo VPS autorizado. Se requiere la dirección del VPS. Solo el propietario del contrato puede llamar a esta función.
* __checkUVPS(address _vps)__: Esta función verifica si un VPS está duplicado. Recibe la dirección del VPS a verificar y devuelve un valor booleano que indica si el VPS está duplicado o no.
* __AutoVPS(address _vps, bool _permiso)__: Esta función autoriza o deniega un VPS. Recibe la dirección del VPS y el estado de autorización. Solo el propietario del contrato puede llamar a esta función.
* __findUVPS(address _vps)__: Esta función busca un VPS por su dirección y devuelve el índice del VPS encontrado. Si el VPS no se encuentra, se genera una excepción.
* __findVPS(address _vps)__: Esta función busca un VPS por su dirección y estado de autorización. Devuelve un valor booleano que indica si el VPS está autorizado o no.
* __id_VPS(address wallet)__: Esta función obtiene el ID del VPS por su dirección de wallet. Recibe la dirección de la wallet y devuelve el ID del VPS encontrado.

En resumen, el contrato __"Wallets"__ permite gestionar las wallets de los usuarios registrados en la red Scolcoin, manteniendo un control sobre los VPS autorizados y su relación con las wallets. Proporciona funciones para crear, consultar y autorizar wallets y VPS, brindando seguridad y control en la gestión de los activos en la red.
