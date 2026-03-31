# fah-public-task

Tarea pública de la plataforma Synergia para contribuir a la investigación científica de Folding@home.

## ¿Qué hace?

Ejecuta el cliente de Folding@home dentro de un contenedor Docker aislado. Los resultados (work units completadas) se envían directamente a los servidores de Folding@home, contribuyendo a la investigación de enfermedades como el cáncer y el Alzheimer.

## ¿Por qué existe?

Esta tarea resuelve el problema de arranque (credit deadlock) de la plataforma Synergia. Los workers nuevos sin créditos pueden procesar esta tarea para ganar créditos iniciales y así poder publicar sus propias tareas.

## Equipo FAH

- **Team:** Synergia (ID: 1067987)
- **Proyecto:** Investigación de plegamiento de proteínas

## Uso

```bash
make setup   # instala FAH
make run     # ejecuta una work unit
```
