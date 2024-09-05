# Changelog

Todas las modificaciones significativas en el proyecto se registrarán en este archivo.

## [Sin Publicar]

### Cambiado

### Añadido

### Arreglado

### Quitado

---

## [1.3.1] - 2024-09-05

### Cambiado

- Corregido el name del docker-compose
- Corregido el montaje en red para las backups

## [1.3.0] - 2024-09-05

### Añadido

- Script para montar volúmenes en red
- Configuraciones de crontab en el script de instalación setup.sh
- Script de Python para exportar métricas del servidor de Minecraft
- Script para establecer como servicio la exportación de métricas de Minecraft
- Script para instalar el servidor de Minecraft en sistemas Windows
- Mod CarbonConfig-Neoforge-1.21-1.2.9.2
- Mod Chunk-Pregenerator-Neoforge-1.21-4.4.5

### Cambiado

- Proceso de instalación de Docker en el archivo setup.sh
- Proceso de instalación de Docker-Compose en el archivo setup.sh
- Proceso de realización de la copia de seguridad

### Quitado

---

## [1.2.4] - 2024-08-08

### Cambiado

- Fichero README para referenciar la licencia

---

## [1.2.3] - 2024-08-07

### Añadido

- Fichero para gestionar las variables de entorno

### Cambiado

- Docker Compose modificado para obtener las variables de entorno
- Docker Compose modificado para quitar la referencia al fichero de texto de mods
- Docker Compose modificado para añadir un hostname al contenedor
- Fichero de variables de entorno de ejemplo

### Quitado

- Fichero de texto con el listado de mods

---

## [1.2.2] - 2024-08-06

### Cambiado

- Mods actualizados a su ultima versión
- Mods añadidos al README.md

---

## [1.2.1] - 2024-08-05

### Añadido

- Apartado en el README.md para montar una carpeta en red

### Cambiado

- Script para realizar copias de seguridad a 2 días

### Quitado

- Script para purgar Docker

---

## [1.2.0] - 2024-07-31

### Cambiado

- Script para borrar las copias de seguridad de más de 7 días

---

## [1.1.0] - 2024-07-24

### Añadido

- Ejemplo de variables de entorno
- Script para realizar copias de seguridad

---

## [1.0.0] - 2024-07-16

### Añadido

- Configuración inicial del proyecto
- Docker Compose para iniciar el servidor de Minecraft
- Scripts de instalación y configuración básica
- Documentación del repostiorio
- Mods para la optimización del servidor
