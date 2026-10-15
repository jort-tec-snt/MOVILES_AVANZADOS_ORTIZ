# SEMANA 07 – GLAB-S07 Manejo de Datos: Tablas y Colecciones (UIKit)

| Parte | Proyecto | Qué muestra |
|---|---|---|
| A | `GLAB07A_Profesores` | `UITableView` con celda `"celda"` (estilo Subtitle), clase `Profesor` (nombre, cargo, foto), `dequeueReusableCell` |
| B | `GLAB07B_Personas` | Celda personalizada `PersonasTableViewCell` (imagen + label) y alerta en `didSelectRowAt` |
| C | `GLAB07C_Culturas` | Lista de 6 culturas peruanas con foto → detalle (imagen grande, nombre, región, descripción) |

Abrir: `open SEMANA07/<proyecto>/<proyecto>.xcodeproj`

## Decisiones

- **UI de A y B por código; C con el diseño en Storyboard y la información en los controladores.** En C las pantallas, imágenes de Assets, colores con nombre y segue se ven en `Main.storyboard`; los datos viven en `CulturasViewController` y `DetalleCulturaViewController`.
- **Un proyecto por ejercicio** (la guía crea otra aplicación para la parte B).
- **Propiedad `cargo`** en `Profesor`, como en la guía; se muestra como subtítulo.
- **Imágenes A y B:** placeholders (círculo de color + SF Symbol) guardados en Assets. Se pueden reemplazar por fotos reales manteniendo el nombre del imageset.
- **Imágenes C:** fotos reales de Caral, Chavín, Paracas, Nazca e Inca (aportadas por el autor, reducidas a JPEG). **Moche** también tiene su foto (imageset `moche`).
- **Culturas:** 6 (Caral, Chavín, Paracas, Nazca, Moche, Inca). La guía no fija la cantidad.
- **Navegación de C:** celda prototipo con un segue `verDetalle` (Show) hacia una sola escena de detalle. `CulturasViewController.prepare(for:sender:)` entrega nombre, región e imagen de la fila elegida; el detalle busca el resto de su información por nombre.

## Interfaz de C

- **Storyboard (`Main.storyboard`):** Navigation Controller → lista con celda prototipo → segue `verDetalle` → una escena de detalle diseñada completa (se ve en el canvas con Nazca como ejemplo: imagen de Assets, color con nombre, tarjeta, iconos, periodo, descripción, aportes y sitios).
- **`CulturasViewController`:** guarda nombre, región e imagen de las 6 culturas, llena las celdas (por tag: 1 imagen, 2 nombre, 3 región) y entrega la elegida por el segue.
- **`DetalleCulturaViewController`:** guarda periodo, descripción, aportes y sitios de cada cultura, los carga en la escena y aplica el color de la cultura (`AcentoCaral`, `AcentoChavin`, `AcentoParacas`, `AcentoNazca`, `AcentoMoche`, `AcentoInca` en Assets). Las secciones sin datos no se muestran.
- **Información ampliada:** Nazca e Inca tienen **Aportes** y **Sitios emblemáticos**; las demás muestran periodo y descripción.

### Ver el diseño y el segue en Xcode

1. Abrir `GLAB07C_Culturas.xcodeproj` y luego `Main.storyboard`.
2. `Editor > Canvas > Zoom to Fit` para ver las tres escenas y las flechas.
3. En la escena de detalle, seleccionar la imagen, la etiqueta de región o un título y revisar en el Attributes Inspector la imagen de Assets, los colores con nombre y las fuentes.
4. Clic en el círculo de la flecha entre lista y detalle: Identifier `verDetalle`, Kind Show.

## Conclusiones (borrador)

1. `UITableView` necesita `dataSource` (cuántas filas y qué celda) y `delegate` (qué pasa al seleccionar); reutilizar celdas con `dequeueReusableCell` evita crear una vista por fila.
2. Una celda personalizada (`PersonasTableViewCell`) permite controlar el diseño de cada fila con sus propios outlets, más allá de los estilos predefinidos.
3. Para pasar datos entre pantallas se crea el controlador destino, se le asigna el modelo seleccionado y se navega con `UINavigationController`, así el detalle solo depende del dato recibido.
