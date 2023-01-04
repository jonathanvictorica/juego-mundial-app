# ☕🎯 Juego App Mundial - JAVA

## Índice

- [Motivación](#-motivacion)
- [Objetivo del Juego](#-objetivo-del-juego)
- [Play](#-play)
- [Documentación Técnica de la Solución](#-documentacin-tcnica-de-la-solucin)
    - [Modelo de Base de Datos](#-modelo-de-base-de-datos)
    - [Diagrama de Clases](#diagrama-de-clases)
    - [Tecnologías](#-tecnologas)
    - [Remasterización](#-remasterizacin)
- [Demo](#-demo)

## 🚀 Motivación

Este proyecto fue desarrollado en la época del mundial 2014. 

## 🚀 Objetivo del Juego

El juego Mundial app tiene como objetivo completar el album del mundial del grupo que jugaba Argentina en el mundial del 2014.
La idea es ganar figuritas y combos, respondiendo preguntas relacionadas con el mundial. Si el jugador 
gana una figurita que ya tiene en el album, puede canjearla por otra figurita que no tenga, y además tiene
que ser de la misma complejidad de conseguir que la figurita que tiene. Es decir no puede cambiar una figurita Facil por otra Dificil.

## 🚀 Play

* Si es la primera vez que va a ejecutar el proyecto en su máquina, ejecutar el archivo execute-1-instalacion.sh
* Para inicializar el entorno de datos ejecutar execute-2-configuracion.sh
* Por último, para jugar el juego, debe ejecutar execute-3-execute.sh

Notas: Recuerde que cada vez que ejecute execute-2-configuracion.sh se pisaran los datos de las partidas que ya haya jugado.
Nota2: Cada vez que quiera jugar el juego solo tiene que ejecutar execute-3-execute.sh


## 🚀 Documentación Técnica de la Solución

### Modelo de Base de Datos
En este diagrama se presentan las entidades más relevantes de la base de datos.

![Modelo de Base de Datos](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/der.png)

### Diagrama de Clases
A continuación se presentan los diagramas de clases de los módulos principales
#### Diagrama de Clases del Modelo
![Diagrama de Clases](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/DC.png)
#### Diagrama de Clases del Controller
![Diagrama de Clases](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/DC_Controller.png)

### Tecnologías
* JDK 17
* Mysql
* Librerías: AbsoluteLayout.jar y EdisoncorSX.jar (para interfaz gráfica desktop)
* Spring Boot 2.7.5
* Maven
* Docker (solamente para la BBDD mysql)

### Remasterización

Cuando se desarrolló este juego, se usó JDK 1.8. Es por esta razón que decidí actualizarlo para que sea un proyecto spring-boot con maven, y un JDK 17.

Tareas Pendiente: Implementar algún ORM como spring-jpa-data, o spring-mongodb y sacar la lógica implementada en la base de datos a través de procedimientos almacenados.

## 🚀 Demo
* Pantalla de login donde se puede iniciar una partida nueva, o retomar una existente
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/1.png) <br />
* Se crea una partida nueva
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/2.png) <br />
* Pantalla principal
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/3.png) <br />
* Seleccionar opción FIGURITAS y elegir alguna para jugar
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/4.png) <br />
* Jugar la trivia de preguntas
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/5.png) <br />
* Si responde correctamente la trivia gana la figurita
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/6.png) <br />
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/7.png) <br />
* Además de jugar por figuritas,se puede jugar por combos de 6 figuritas prearmados. Pero las preguntas son más dificiles.
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/8.png) <br />
* Pregunta trivia por combo
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/9.png) <br />
* Visualización de album digital
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/10.png) <br />
* En caso de ganar ya sea por combo de figuritas o figuritas individuales alguna que ya se tiene coleccionada, el juego da la posbilidad de canjearla por otra figurita que tenga el mismo nivel de dificultad.
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/11.png) <br />
* Pantalla de canje de figuritas
![Demo](https://github.com/jonathanvictorica/juego-mundial-app/blob/develop/docs/12.png) <br />




