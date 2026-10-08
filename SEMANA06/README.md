# Semana 06 — Gestión de vistas y navegación (UIKit)

El código **no está en `main`**: `main` solo guarda esta guía de navegación.
La semana tiene **dos tipos de trabajo**, cada uno en su propia rama, sobre el mismo proyecto `GLAB06`.

| Tipo | Rama | Qué contiene |
|---|---|---|
| Manual (sin IA) | `manual` | Navegación `Show`, `ClienteModel`, formulario de cliente, modal de confirmación |
| Con IA | `con-ia` | Lo anterior + rediseño visual, Ejercicio 4 (venta a plazos: `VentaModel`, Nueva Venta, Resultado), App Icon, `PROMPTS.md`, `ENTREGA.md` |

Ruta del proyecto en ambas ramas: `SEMANA06/GLAB06/GLAB06.xcodeproj`

## Ver el trabajo manual

```bash
git switch manual
open SEMANA06/GLAB06/GLAB06.xcodeproj
```

## Ver el trabajo con IA

```bash
git switch con-ia
open SEMANA06/GLAB06/GLAB06.xcodeproj
```

Documentación adicional (solo en `con-ia`): `SEMANA06/README.md` (comparativa y conclusiones), `PROMPTS.md` (prompts y reflexión) y `ENTREGA.md` (checklist de entrega).

## Ver ambas versiones a la vez

```bash
git worktree add ../GLAB06-manual manual
git worktree add ../GLAB06-con-ia con-ia
open ../GLAB06-manual/SEMANA06/GLAB06/GLAB06.xcodeproj
open ../GLAB06-con-ia/SEMANA06/GLAB06/GLAB06.xcodeproj
```

Al terminar: `git worktree remove ../GLAB06-manual && git worktree remove ../GLAB06-con-ia`

## Compilar desde terminal

```bash
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
xcodebuild -project SEMANA06/GLAB06/GLAB06.xcodeproj -scheme GLAB06 \
  -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/GLAB06DD build
```

Volver a esta guía: `git switch main`.
