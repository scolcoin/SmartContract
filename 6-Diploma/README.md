// pragma solidity 0.8.18; Op 5000 
Direccion: 0xf92eA40F27d2797773ea48066dc6f16c2ddDd5b1

# Documento: Contrato DiplomaMaster

## Introducción

El contrato DiplomaMaster es un smart contract escrito en Solidity que se utiliza para gestionar diplomas en la blockchain. Este contrato permite la emisión, almacenamiento y consulta de diplomas, así como la autorización de VPS (Servidores Privados Virtuales) para interactuar con el contrato.

## Funcionalidades del Contrato

El contrato DiplomaMaster proporciona las siguientes funcionalidades:

### Almacenamiento de Diplomas

Los usuarios autorizados pueden almacenar diplomas en la blockchain proporcionando información detallada sobre el diploma, como nombre del titular, número de cédula, horas de estudio, módulos completados, nivel alcanzado, metodología, URI (Identificador Uniforme de Recursos) del diploma y la dirección de la wallet del titular del diploma.

### Consulta de Diplomas

Los usuarios pueden consultar los diplomas almacenados en la blockchain mediante su ID de diploma o su hash.

### Autorización de VPS

Los propietarios del contrato pueden autorizar o desautorizar direcciones de VPS para interactuar con el contrato y realizar operaciones de almacenamiento y consulta de diplomas.

## Estructura del Contrato

El contrato DiplomaMaster se compone de las siguientes partes:

### Estructura Diploma

Define la estructura de datos para representar un diploma, incluyendo campos como nombre, cédula, horas, módulos, nivel, metodología, URI y dirección de la wallet del titular.

### Mapeos

Utiliza mapeos para asociar ID de diploma, hash de diploma y dirección de VPS con los diplomas correspondientes.

### Conjunto de VPS Autorizadas

Utiliza un conjunto de direcciones de VPS autorizadas para controlar el acceso al contrato.

### Eventos

Emite eventos para notificar sobre la autorización de VPS.

### Funciones

Proporciona funciones públicas para almacenar diplomas, consultar diplomas, autorizar VPS y establecer URI de diploma.

### Modificadores

Utiliza modificadores para restringir el acceso a ciertas funciones solo a VPS autorizadas.

## Implementación

El contrato DiplomaMaster se implementa utilizando la biblioteca OpenZeppelin para ERC721 (Tokens No Fungibles) y Ownable (control de propiedad).

## Conclusiones

El contrato DiplomaMaster ofrece una solución segura y transparente para el almacenamiento y consulta de diplomas en la blockchain. Proporciona una manera eficiente de gestionar y verificar la autenticidad de los diplomas emitidos, así como controlar el acceso a las funciones del contrato.

Este contrato puede ser utilizado por instituciones educativas, empresas y organizaciones que deseen utilizar la tecnología blockchain para emitir y gestionar diplomas de manera descentralizada y segura.
