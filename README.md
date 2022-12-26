# ☕🎯 Juego App Mundial - JAVA

## Índice

* [Motivación](#-motivacion)
* [Objetivo del Juego ](#-objetivo-del-juego)
* [Remasterización](#-remasterizacin)
* [Tecnologías](#-tecnologías)
* [Play](#-play)

## 🚀 Motivación

Este proyecto fue desarrollado en la época del mundial 2014. 


## 🚀 Objetivo del Juego

El juego Mundial app tiene como objetivo completar el album del mundial del grupo que jugaba Argentina en el mundial del 2014.
La idea es ganar figuritas y combos, respondiendo preguntas relacionadas con el mundial. Si el jugador 
gana una figurita que ya tiene en el album, puede canjearla por otra figurita que no tenga, y además tiene
que ser de la misma complejidad de conseguir que la figurita que tiene. Es decir no puede cambiar una figurita Facil por otra Dificil.


## 🚀 Remasterización

Cuando se desarrolló este juego, se usó JDK 1.8. Es por esta razón que decidí actualizarlo para que sea un proyecto spring-boot con maven, y un JDK 17.


Tareas Pendiente: Implementar algún ORM como spring-jpa-data, o spring-mongodb y sacar la lógica implementada en la base de datos a través de procedimientos almacenados.

## 🚀 Tecnologías

* JDK 17
* Mysql
* Librerias: AbsoluteLayout.jar y EdisoncorSX.jar (para interfaz gráfica desktop)
* Spring Boot 2.7.5
* Maven
* Docker (solamente para la BBDD mysql)

## 🚀 Play

* Si es la primera vez que va ejecutar el proyecto en su máquina, ejecutar el archivo execute-1-instalacion.sh
* Para inicializar el entorno de datos ejecutar execute-2-configuracion.sh
* Por último, para jugar el juego, debe ejecutar execute-3-execute.sh

Notas: Recuerde que cada vez que ejecute execute-2-configuracion.sh se pisaran los datos de las partidas que ya haya jugado.
Nota2: Cada vez que quiera jugar el juego solo tiene que ejecutar execute-3-execute.sh



