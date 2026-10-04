# Semana 06 - Gestión de vistas y navegación UIKit

## Objetivo

Practicar la gestión de vistas y la navegación en una aplicación iOS académica construida con UIKit y Storyboard. El ejercicio captura datos básicos de un cliente, conserva una navegación jerárquica y presenta una confirmación modal.

## Implementación base

La rama `con-ia` parte de la solución funcional de la rama `manual`. La base ya incluía un `UINavigationController`, un segue `Show`, una presentación modal, tres subclases de `UIViewController` y `ClienteModel` para transportar apellido, nombre y DNI.

## Mejoras realizadas con IA

- Reorganización de las tres pantallas con `UIStackView` y Auto Layout.
- Fondos agrupados y tarjetas con colores semánticos del sistema.
- Jerarquía tipográfica con títulos, subtítulos, etiquetas y valores.
- Campos, botón principal y barra de navegación modernizados.
- SF Symbols para el registro, la navegación y la confirmación.
- Colores dinámicos compatibles con los modos claro y oscuro.
- Conservación del flujo, los `IBOutlet`, el `IBAction`, los segues y el Storyboard ID.

## Prompts utilizados

### Prompt 01 - Mejora visual UIKit

- **Contexto:** aplicación funcional de laboratorio en `con-ia`, evolucionada desde `manual`, con UIKit, Storyboard, navegación `Show` y modal, tres controladores y `ClienteModel`.
- **Tarea:** revisar primero la implementación y modernizar visualmente las pantallas, la navegación, los controles, los espacios y los constraints.
- **Restricciones:** conservar UIKit, Storyboard, `IBOutlet`, `IBAction`, `UINavigationController`, segues, clases y lógica; no usar SwiftUI, persistencia, dependencias externas, arquitecturas avanzadas ni animaciones complejas; no modificar la futura calculadora de venta a plazos.
- **Formato esperado:** interfaz nativa con colores semánticos, stacks, tarjetas, SF Symbols, radios moderados, Auto Layout y soporte light/dark; documentación y compilación por CLI.
- **Resultado obtenido:** las tres escenas presentan una composición renovada sin cambiar el flujo de datos ni navegación.
- **Cambios realizados por la IA:** stacks, tarjetas, tipografía, colores dinámicos, iconos, campos y botón modernizados, constraints adaptativos y documentación.
- **Decisiones revisadas manualmente:** apariencia final en distintos tamaños, interacción con el teclado y validación visual de los modos claro y oscuro antes de integrar.

## Comparación manual vs con-ia

| Aspecto | manual | con-ia |
|---|---|---|
| Navegación | `UINavigationController`, segue `Show` y presentación modal | Mantiene el flujo; mejora títulos e icono de la barra |
| Diseño visual | Controles y etiquetas con presentación básica | Fondos agrupados, tarjetas, SF Symbols y jerarquía tipográfica |
| Formulario | Etiquetas y campos independientes | Tarjeta con stacks, campos de 48 pt y botón destacado |
| Pantalla de confirmación | Título y tres pares de etiquetas | Encabezado visual y tarjeta con valores separados |
| Auto Layout | Constraints individuales | Stacks anidados, márgenes consistentes y contenido desplazable |
| Soporte light/dark | Fondo dinámico `systemBackground` | Paleta semántica con fondos agrupados, labels y separadores |
| Asistencia IA | Implementación manual base | Revisión, propuesta visual, edición, documentación y verificación CLI |

## Ejecución por CLI

Comandos utilizados:

```bash
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer

xcodebuild \
  -project SEMANA06/GLAB06/GLAB06.xcodeproj \
  -scheme GLAB06 \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/GLAB06DerivedData \
  build

xcrun simctl install <device-udid> /tmp/GLAB06DerivedData/Build/Products/Debug-iphonesimulator/GLAB06.app
xcrun simctl launch <device-udid> pe.edu.tecsup.GLAB06
```

En Xcode 27, el comando utilizado para abrir Device Hub es:

```bash
open -b com.apple.dt.Devices
```

## Reflexión

La IA aportó una revisión sistemática y una evolución visual basada en componentes nativos. La revisión manual sigue siendo necesaria para evaluar la apariencia en diferentes dispositivos, el teclado y ambos modos de color. `con-ia` evoluciona `manual` porque conserva el modelo, los controladores y la navegación funcional, pero mejora de forma verificable la composición, los estilos y la adaptabilidad.
