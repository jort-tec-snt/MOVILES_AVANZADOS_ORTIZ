# Semana 07 — Manejo de datos: tablas y colecciones (UIKit)

El código **no está en `main`**: `main` solo guarda esta guía de navegación.
La semana tiene un solo tipo de trabajo, en la rama `manual`, con **tres proyectos** (uno por ejercicio de la guía).

| Parte | Proyecto | Qué contiene |
|---|---|---|
| A | `GLAB07A_Profesores` | `UITableView` con celda `celda` (estilo Subtitle), clase `Profesor`, reuso de celdas, fotos desde Assets |
| B | `GLAB07B_Personas` | Celda personalizada `PersonasTableViewCell` (imagen + label) y alerta en `didSelectRowAt` |
| C | `GLAB07C_Culturas` | Caso a desarrollar: lista de culturas peruanas con foto y pantalla de detalle (imagen, nombre, región, descripción) |

Ruta de los proyectos: `SEMANA07/<proyecto>/<proyecto>.xcodeproj`

## Ver el trabajo

```bash
git switch manual
open SEMANA07/GLAB07C_Culturas/GLAB07C_Culturas.xcodeproj   # caso C (cambia el nombre para A o B)
```

Pulsar **Run** (⌘R) con un iPhone como destino.

## Qué ver en el caso C

1. **Lista**: cada cultura con su foto, nombre y región. Archivos: `CulturaTableViewCell.swift`, `CulturasViewController.swift`.
2. **Detalle** al tocar una fila: imagen grande, nombre, región, descripción. Archivo: `DetalleCulturaViewController.swift`.
3. **Paso de datos**: el detalle recibe la `Cultura` por propiedad y se muestra con `pushViewController` en un `UINavigationController` (sin segue, porque la UI está hecha por código).
4. **Datos y fotos**: `Cultura.swift` y `Assets.xcassets` (`caral`, `chavin`, `paracas`, `nazca`, `moche`, `inca`).

Detalle de decisiones y borrador de conclusiones: `SEMANA07/README.md` en la rama `manual`.

## Compilar desde terminal

```bash
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
xcodebuild -project SEMANA07/GLAB07C_Culturas/GLAB07C_Culturas.xcodeproj -scheme GLAB07C_Culturas \
  -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/GLAB07C_CulturasDD build
```

Volver a esta guía: `git switch main`.
