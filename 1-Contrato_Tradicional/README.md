# Descripción Contrato Prestacion de Servicios
El archivo acuerdo.sol Prestacion de Servicios, basado en un documento tradicional que incluso tiene la opcion para cargar el Uri de IPFS para que este la constancia escaneada como prueba certificada, nunca mas volveras a una notaria. acuerdo.sol es un contrato inteligente en Solidity, que sirve para gestionar un acuerdo entre dos partes. Incluye un proceso de retiro en caso de ley de retracto, y la capacidad de verificar cláusulas y agregar trazas de proceso.

El contrato tiene algunas variables para almacenar información del contratista y contratante, como nombre, cédula, dirección, correo y celular. También tiene variables para almacenar información del administrador y proveedor, como dirección y si están autorizados. El contrato tiene una función constructora que crea una nueva instancia del contrato Acuerdo, donde se establece la URL del tokenURI, la dirección de la cuenta del administrador y del proveedor, y un mensaje de clave. También tiene una función para depositar Scolcoin SRC-20 en el contrato.

El contrato tiene una función para ejecutar el retiro de Scolcoin SRC-20 según el caso el contratante quede a satisfaccion, por medio de unas herramientas de auditoriza y trazabilidades de procesos, podra autorizar el proceso de pago al Proveedor (Contratista) AUTO=True los fondos pasan a la wallet del Contratista (Pro). 

También tiene una función LeyRetiro que establece si una de las partes ha invocado la ley de retracto y/o el Contratante acude a entidades estatales regulatorias o de arbitraje, podra invocado Ley de Retiro, si ambas partes o un juez ordena, se ejecuta el retiro por ley de retracto, los fondos pasan a la cuenta del remitente sea la cuenta del Administrador (Contratista). 

El contrato tiene funciones para establecer información del contratista y contratante, así como funciones para establecer si el administrador y proveedor están autorizados.

### Cumpliendo con la trazabilidad digital y autenticidad de la Ley 527 de 1999 de Republica de Colombia.

## Acuerdo Tradicional:
Variables iniciales en constructor con Autenticidad:

- Partes: admin(Owner) Funcion Contratante()
- Proveedor Pro, Funcion Contratista ().

## Datos Generales de un Acuerdo Tradicional:
1 - OBJETO.

2 - SUJETO CONTRACTUALES

3 - CONSENTIMIENTO

4 - PERFECCIONAMIENTO DE EJECUCIÓN

5 - TERMINACIÓN

Agrupado en Funcion Clausulas() el Owner debe configurarlas inicialmente y cada una basado del documento fisico, al ingresar a la blockchain y por seguridad se encripta, la unica forma de confirmar es enviando en la funcion: allClausulas() 

## Otras Herramientas Importantes para poder llevar el seguimiento:
- Firma.
- No repudio firma digital.
- Trazabilidad de los Procesos.
- Auditoria.
- Ejecucion.
- Pago.

# Instrucciones:
en el codigo encontraras con // y el numero del proceso.

1- El Creador es el Admin y Owner, debe seguir estas recomendaciones en el momento de almacenar la informacion en Remix debe suministrar: URL(Link CID -IPFS), administrador, Proveedor, Numero de Clausulas, Mensaje Key para Firmar el acuerdo.

