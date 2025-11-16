# El juego de mesa Rummikub según las reglas Sabra.

## Implementado en CLIPS y Python.

Este proyecto desarrolla un programa para jugar a **Rummikub** usando **CLIPS** y **Python-Tkinter** para la GUI, con comunicación vía Routers y clipspy. CLIPS gestiona fichas duplicadas con secuencias, usa random y salience para reglas, y módulos/variables globales, sin POO. La GUI, creada con Pygubu y mejorada con IA (GitHub Copilot, Claude Sonnet, Google Gemini), incluye Drag and Drop. El programa es funcional y **ampliable**.

Diseño híbrido: CLIPS se encarga de la lógica y la toma de decisiones, mientras que Python gestiona la presentación y la interacción.

## El Juego Rummikub (Reglas Sabra)

+ Juego de mesa con fichas numéricas de colores que incluye un componente de azar, diseñado para 2 a 4 jugadores (adaptado a 2 en esta versión).
+ Objetivo: Ser el primer jugador en deshacerse de todas sus fichas.
+ Se juega con 104 fichas numeradas (1 al 13 en cuatro colores: negro, rojo, azul y amarillo/naranja) más 2 comodines.
+ Hay dos unidades idénticas de cada ficha. La base de fichas inicial es de 14 por jugador.
+ Combinaciones posibles:
    + Escalera: Mínimo 3 fichas, mismo color, números consecutivos.
    + Serie: Mínimo 3 fichas, mismo número, diferentes colores (máx. 4).

## CLIPS (C Language Integrated Production System)
+ Es un sistema experto desarrollado por la NASA.
+ Implementa el paradigma de Sistema de Producción (Memoria de Trabajo, Base de Reglas, Motor de Inferencia).
+ Permite un enfoque declarativo donde las reglas se definen
formalmente.
+ Referencia: [clipsrules.net](https://www.clipsrules.net/)

## Python
+ Es el lenguaje de propósito general elegido.
+ Tkinter es la librería estándar de Python para GUI, seleccionada por su integración nativa, facilidad de uso y compatibilidad multiplataforma.

## Comunicación CLIPS &harr; Python: clipspy y Routers
+ La librería clipspy es esencial para el intercambio bidireccional de información entre Python y el binario de CLIPS.
    + clipspy encapsula las llamadas a CLIPS en objetos y métodos Python, permitiendo a Python enviar comandos (eval()) y ejecutar el motor (run()) entre otros.
    + Es fundamental para la comunicación sin tener que interactuar directamente con código C.
+ Los Routers de CLIPS canalizan la salida por consola (stdout) del motor hacia la interfaz gráfica de Python.

### clipspy y Python
+ La integración depende de [clipspy](https://github.com/noxdafox/clipspy) (interfaz de alto nivel) y [cffi](https://github.com/python-cffi/cffi) (C Foreign Function Interface), que es fundamental para que Python pueda interactuar con el binario de CLIPS (escrito en C).
+ También necesaria [pycparser](https://github.com/eliben/pycparser).

## Referencias
+ J. C. Giarratano y G. D. Riley. Expert Systems: Principles and Programming. 4th ed. Boston. MA: Thomson Course Technology. 2005.
+ Secret Society Software. CLIPS Reference Manual, Volume I - Basic Programming Guide. Versión 6.4.2. Gary D. Riley - Secret Society Software, LLC. 16 de enero de 2025.
+ Secret Society Software. CLIPS Reference Manual, Volume II - Advanced Programming Guide. Versión 6.4.2. Gary D. Riley - Secret Society Software, LLC. 16 de enero de 2025.
+ J. E. Grayson. Python and Tkinter programming. Shelter Island. NY: Manning. 2000.