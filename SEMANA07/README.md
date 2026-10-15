# Semana 07 — Manejo de datos: tablas y colecciones (UIKit)

El código **no está en `main`**: `main` solo guarda esta guía de navegación.
La semana tiene un solo tipo de trabajo, en la rama `manual`, con **tres proyectos** (uno por ejercicio de la guía).

| Parte | Proyecto | Qué contiene |
|---|---|---|
| A | `GLAB07A_Profesores` | `UITableView` con celda `celda` (estilo Subtitle), clase `Profesor`, reuso de celdas, fotos desde Assets |
| B | `GLAB07B_Personas` | Celda personalizada `PersonasTableViewCell` (imagen + label) y alerta en `didSelectRowAt` |
| C | `GLAB07C_Culturas` | Caso a desarrollar: culturas peruanas. El proyecto está en esta semana y su explicación completa (segues, GIF y Storyboard) está en [SEMANA08](../SEMANA08/README.md) |

Ruta de los proyectos: `SEMANA07/<proyecto>/<proyecto>.xcodeproj`

## Ver el trabajo

```bash
git switch manual
open SEMANA07/GLAB07C_Culturas/GLAB07C_Culturas.xcodeproj   # caso C (cambia el nombre para A o B)
```

Pulsar **Run** (⌘R) con un iPhone como destino.

## Caso C

El caso de las culturas peruanas se explica en [SEMANA08](../SEMANA08/README.md): flujo de pantallas, segues, identificadores y demo en GIF.

## Compilar desde terminal

```bash
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
xcodebuild -project SEMANA07/GLAB07C_Culturas/GLAB07C_Culturas.xcodeproj -scheme GLAB07C_Culturas \
  -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/GLAB07C_CulturasDD build
```

Volver a esta guía: `git switch main`.
