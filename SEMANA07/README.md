# SEMANA 07 – GLAB-S07 Manejo de Datos: Tablas y Colecciones (UIKit)

| Parte | Proyecto | Qué muestra |
|---|---|---|
| A | `GLAB07A_Profesores` | `UITableView` con celda `"celda"` (estilo Subtitle), clase `Profesor` (nombre, cargo, foto), `dequeueReusableCell` |
| B | `GLAB07B_Personas` | Celda personalizada `PersonasTableViewCell` (imagen + label) y alerta en `didSelectRowAt` |
| C | `GLAB07C_Culturas` | Lista de 6 culturas peruanas con foto → detalle (imagen grande, nombre, región, descripción) |

Abrir: `open SEMANA07/<proyecto>/<proyecto>.xcodeproj`

## Decisiones

- **UI de A y B por código; C con la maqueta en Storyboard.** La lista de las 6 culturas y los detalles de Nazca e Inca están diseñados por completo en `Main.storyboard`. Caral, Chavín, Paracas y Moche usan un detalle básico cuya información guardan los controladores.
- **Un proyecto por ejercicio** (la guía crea otra aplicación para la parte B).
- **Propiedad `cargo`** en `Profesor`, como en la guía; se muestra como subtítulo.
- **Imágenes A y B:** placeholders (círculo de color + SF Symbol) guardados en Assets. Se pueden reemplazar por fotos reales manteniendo el nombre del imageset.
- **Imágenes C:** fotos reales de Caral, Chavín, Paracas, Nazca e Inca (aportadas por el autor, reducidas a JPEG). **Moche** también tiene su foto (imageset `moche`).
- **Culturas:** 6 (Caral, Chavín, Paracas, Nazca, Moche, Inca). La guía no fija la cantidad.
- **Navegación de C:** lista de celdas estáticas con un segue por fila. `verNazca` y `verInca` llevan a escenas de detalle minucioso diseñadas en el Storyboard; `verDetalle` (las otras 4) lleva a una escena básica, y `CulturasViewController.prepare(for:sender:)` le entrega nombre, región e imagen.

## Interfaz de C

- **Storyboard (`Main.storyboard`):** Navigation Controller → lista con las 6 culturas (imagen de Assets, nombre y región en cada fila) → 3 escenas de detalle:
  - **Nazca** e **Inca**: detalle minucioso construido en el canvas (imagen, color con nombre, tarjeta, región, periodo, descripción, aportes y sitios emblemáticos).
  - **Detalle básico** (Caral, Chavín, Paracas y Moche): una sola escena que cargan los controladores.
- **Lugares turísticos:** cada detalle tiene un botón "Ver lugares turísticos" (segue `verLugares`, Show) hacia una pantalla con los sitios de la zona de esa cultura (3 o 4 por cultura), diseñada en el Storyboard con una celda prototipo (icono con el color de la cultura, nombre, ubicación y descripción). Cada lugar es una fila con flecha que lleva (segue `verLugar`) a su propio **detalle del lugar**: foto (o banda de color si no tiene), nombre, ubicación, descripción y, en los lugares del Inca, una lista "Qué ver". Los lugares de Nazca e Inca tienen foto (miniatura en la lista y foto grande en el detalle, en `Assets.xcassets` como `lugar_*`); los de las demás culturas usan un icono con el color de la cultura.
- **`CulturasViewController`:** guarda nombre, región e imagen de las 6 culturas y entrega la fila elegida por el segue `verDetalle`.
- **`DetalleCulturaViewController`:** guarda periodo y descripción de las 4 culturas básicas, carga la escena, aplica el color de la cultura (`AcentoCaral`, `AcentoChavin`, `AcentoParacas`, `AcentoMoche` en Assets) y entrega la cultura a Lugares.
- **`DetalleMinuciosoViewController`:** en Nazca e Inca solo entrega la cultura a Lugares.
- **`LugaresViewController`:** guarda los lugares de cada cultura (modelo `Lugar`), llena la tabla y entrega el lugar elegido al detalle.
- **`LugarDetalleViewController`:** carga el detalle del lugar recibido y aplica el color de su cultura; la sección "Qué ver" solo aparece si el lugar tiene datos.
- **Código:** cinco controladores pequeños, `AppDelegate` y `SceneDelegate`.

### Ver el diseño y los segues en Xcode

1. Abrir `GLAB07C_Culturas.xcodeproj` y luego `Main.storyboard`.
2. `Editor > Canvas > Zoom to Fit` para ver las 7 escenas y las flechas.
3. En las escenas de Nazca e Inca, seleccionar la imagen, la etiqueta de región o un título y revisar en el Attributes Inspector la imagen de Assets, los colores con nombre y las fuentes.
4. Clic en el círculo de una flecha de la lista: Identifier `verNazca`, `verInca` o `verDetalle` (Kind Show). Los botones de los detalles usan `verLugares` y las filas de lugares `verLugar`.

### Identificadores del Storyboard (caso C)

| Qué | Identificador |
|---|---|
| Escenas (Storyboard ID) | `NavegacionCulturas`, `CulturasViewController`, `DetalleCulturaViewController`, `DetalleNazca`, `DetalleInca`, `LugaresViewController`, `LugarDetalleViewController` |
| Celdas de "Culturas del Perú" (Identifier) | `celdaCaral`, `celdaChavin`, `celdaParacas`, `celdaNazca`, `celdaMoche`, `celdaInca` |
| Celda de lugares (Identifier) | `lugarCell` |
| Segues (Identifier) | `verDetalle` (Caral, Chavín, Paracas, Moche), `verNazca`, `verInca`, `verLugares` (botón de cada detalle), `verLugar` (fila de lugares) |

Dónde verlos en Xcode: en la escena, el **Identity Inspector** (Storyboard ID); en la celda, el **Attributes Inspector** (Identifier); en la flecha del segue, el **Attributes Inspector** (Identifier).

## Conclusiones (borrador)

1. `UITableView` necesita `dataSource` (cuántas filas y qué celda) y `delegate` (qué pasa al seleccionar); reutilizar celdas con `dequeueReusableCell` evita crear una vista por fila.
2. Una celda personalizada (`PersonasTableViewCell`) permite controlar el diseño de cada fila con sus propios outlets, más allá de los estilos predefinidos.
3. Para pasar datos entre pantallas se crea el controlador destino, se le asigna el modelo seleccionado y se navega con `UINavigationController`, así el detalle solo depende del dato recibido.
