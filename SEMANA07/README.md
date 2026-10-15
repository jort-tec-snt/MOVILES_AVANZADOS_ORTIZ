# SEMANA 07 – GLAB-S07 Manejo de Datos: Tablas y Colecciones (UIKit)

| Parte | Proyecto | Qué muestra |
|---|---|---|
| A | `GLAB07A_Profesores` | `UITableView` con celda `"celda"` (estilo Subtitle), clase `Profesor` (nombre, cargo, foto), `dequeueReusableCell` |
| B | `GLAB07B_Personas` | Celda personalizada `PersonasTableViewCell` (imagen + label) y alerta en `didSelectRowAt` |
| C | `GLAB07C_Culturas` | Lista de 6 culturas peruanas con foto → detalle (imagen grande, nombre, región, descripción) |

Abrir: `open SEMANA07/<proyecto>/<proyecto>.xcodeproj`

## Decisiones

- **UI de A y B por código; C íntegramente en Storyboard.** En C todo el diseño (imágenes de Assets, colores con nombre, tipografías, textos y segues) se ve en `Main.storyboard`; el código solo declara los controladores.
- **Un proyecto por ejercicio** (la guía crea otra aplicación para la parte B).
- **Propiedad `cargo`** en `Profesor`, como en la guía; se muestra como subtítulo.
- **Imágenes A y B:** placeholders (círculo de color + SF Symbol) guardados en Assets. Se pueden reemplazar por fotos reales manteniendo el nombre del imageset.
- **Imágenes C:** fotos reales de Caral, Chavín, Paracas, Nazca e Inca (aportadas por el autor, reducidas a JPEG). **Moche** también tiene su foto (imageset `moche`).
- **Culturas:** 6 (Caral, Chavín, Paracas, Nazca, Moche, Inca). La guía no fija la cantidad.
- **Navegación de C:** celdas estáticas, cada una con su segue Show (`verCaral`, `verChavin`, `verParacas`, `verNazca`, `verMoche`, `verInca`) hacia su propia escena de detalle. No hay paso de datos por código: cada escena ya contiene su información.

## Interfaz de C

- **Storyboard:** Navigation Controller → lista (7 escenas en total: lista + 6 detalles). Cada celda tiene un segue a su detalle.
- **Imágenes:** tomadas de `Assets.xcassets` (`caral`, `chavin`, `paracas`, `nazca`, `moche`, `inca`) directamente en los Image View.
- **Colores:** un color con nombre por cultura en Assets (`AcentoCaral`, `AcentoChavin`, `AcentoParacas`, `AcentoNazca`, `AcentoMoche`, `AcentoInca`) aplicado a la etiqueta de región y a los títulos de sección.
- **Detalle:** imagen grande, tarjeta de esquinas redondeadas, nombre, región (etiqueta con icono), periodo, "Acerca de esta cultura" y, en Nazca e Inca, **Aportes** y **Sitios emblemáticos**.
- **Código:** `CulturasViewController` (ajuste de cabecera de la tabla) y `DetalleCulturaViewController` (vacío), más `AppDelegate` y `SceneDelegate`.

### Ver el diseño y los segues en Xcode

1. Abrir `GLAB07C_Culturas.xcodeproj` y luego `Main.storyboard`.
2. `Editor > Canvas > Zoom to Fit` para ver las 7 escenas y las flechas de los segues.
3. Seleccionar una escena de detalle y revisar sus Image View y Label en el Attributes Inspector (imagen de Assets, colores con nombre, fuentes).
4. Clic en el círculo de una flecha: Attributes Inspector con el Identifier (por ejemplo `verNazca`).

## Conclusiones (borrador)

1. `UITableView` necesita `dataSource` (cuántas filas y qué celda) y `delegate` (qué pasa al seleccionar); reutilizar celdas con `dequeueReusableCell` evita crear una vista por fila.
2. Una celda personalizada (`PersonasTableViewCell`) permite controlar el diseño de cada fila con sus propios outlets, más allá de los estilos predefinidos.
3. Para pasar datos entre pantallas se crea el controlador destino, se le asigna el modelo seleccionado y se navega con `UINavigationController`, así el detalle solo depende del dato recibido.
