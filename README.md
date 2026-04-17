# foldingathomesynergia

Tarea pública de la plataforma **Synergia** para contribuir a la investigación científica de [Folding@home](https://foldingathome.org).

## ¿Qué hace?

Ejecuta el cliente de Folding@home (`fah-client`) directamente en el worker. El cliente descarga una *work unit* de los servidores de Folding@home, la procesa usando todos los núcleos de CPU disponibles y sube el resultado automáticamente. Los resultados contribuyen a la investigación de enfermedades como el cáncer o el Alzheimer.

## ¿Por qué existe?

Esta tarea resuelve el **problema de arranque (*credit deadlock*)** de la plataforma Synergia: los workers nuevos sin créditos pueden ejecutar esta tarea para ganar créditos iniciales y así poder publicar o aceptar sus propias tareas.

## Cómo encaja en la plataforma

```
Plataforma Synergia
  │
  ├── lee config.toml
  │     ├── requirements   → instala coreutils, jq
  │     ├── download.files → descarga websocat (cliente WebSocket)
  │     ├── network        → whitelist de hosts de Folding@home
  │     └── outputs.dir    → work/
  │
  └── lanza en cada worker:
        make setup   # descarga e instala fah-client
        make run     # ejecuta una work unit y espera su finalización
```

## Estructura

```
foldingathomesynergia/
├── config.toml          # Configuración para la plataforma (requisitos, red, outputs)
├── Makefile             # Atajos para setup y ejecución
├── setup_fah.sh         # Descarga e instala el binario fah-client
├── control_upload.sh    # Monitoriza el progreso y detiene el cliente al completar la WU
└── fah/                 # (Generado) Binario de Folding@home tras el setup
```

## Setup

```bash
make setup
```

Descarga el paquete `.deb` de `fah-client 8.5.5` y lo extrae localmente en `./fah/`, sin instalación en el sistema.

## Ejecución

```bash
make run
```

El proceso de ejecución sigue estos pasos:

1. Lanza `fah-client` con el equipo Synergia (ID `1067987`) y un `machine-name` único generado aleatoriamente.
2. Usa todos los núcleos de CPU disponibles (`nproc`).
3. Espera 10 segundos y envía el comando `unpause` + `finish` via WebSocket para que el cliente procese exactamente una work unit y luego se detenga.
4. Ejecuta `control_upload.sh`, que monitoriza el progreso de la WU cada 5 minutos. Cuando detecta que el progreso ha reiniciado (nueva WU asignada), deduce que la anterior fue completada y enviada, y termina el proceso.

## Equipo Folding@home

- **Team:** Synergia — ID `1067987`
- **Usuario:** `worker`
- **Proyecto:** Investigación de plegamiento de proteínas

## Dependencias

| Dependencia | Origen | Uso |
|---|---|---|
| `fah-client 8.5.5` | download.foldingathome.org | Cliente principal de F@H |
| `websocat` | GitHub releases | Control del cliente via WebSocket |
| `jq` | paquete del sistema | Parseo de respuestas JSON del cliente |
| `coreutils` | paquete del sistema | Utilidades básicas de shell |

## Red

La plataforma aplica una whitelist de red que permite únicamente conexiones a los dominios oficiales de Folding@home: servidores de asignación (`assign1–6.foldingathome.org`), servidores de work units (`vav17–24.fah.temple.edu`, `highland1–5.seas.upenn.edu`), servidores de cores y APIs.

## Comandos del Makefile

- `make setup`: Descarga e instala el cliente de Folding@home.
- `make run`: Ejecuta una work unit completa y sube el resultado.
- `make clean`: Elimina `gpus.json`, `log.txt`, y los directorios `cores/` y `work/`.
