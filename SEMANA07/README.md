# SEMANA 07 – GLAB-S07 Manejo de Datos: Tablas y Colecciones (UIKit)

| Parte | Proyecto | Qué muestra |
|---|---|---|
| A | `GLAB07A_Profesores` | `UITableView` con celda `"celda"` (estilo Subtitle), clase `Profesor` (nombre, cargo, foto), `dequeueReusableCell` |
| B | `GLAB07B_Personas` | Celda personalizada `PersonasTableViewCell` (imagen + label) y alerta en `didSelectRowAt` |
| C | `GLAB07C_Culturas` | Lista de 6 culturas peruanas con foto → detalle (imagen grande, nombre, región, descripción) |

Abrir: `open SEMANA07/<proyecto>/<proyecto>.xcodeproj`

## Decisiones

- **UI por código, sin Storyboard.** Editar el `.storyboard` a mano es frágil; los pasos de la guía (Table View, constraints, identifier, Subtitle, dataSource/delegate, outlets) están hechos en código con el mismo resultado.
- **Un proyecto por ejercicio** (la guía crea otra aplicación para la parte B).
- **Propiedad `cargo`** en `Profesor`, como en la guía; se muestra como subtítulo.
- **Imágenes A y B:** placeholders (círculo de color + SF Symbol) guardados en Assets. Se pueden reemplazar por fotos reales manteniendo el nombre del imageset.
- **Imágenes C:** fotos reales de Caral, Chavín, Paracas, Nazca e Inca (aportadas por el autor, reducidas a JPEG). **Moche** también tiene su foto (imageset `moche`).
- **Culturas:** 6 (Caral, Chavín, Paracas, Nazca, Moche, Inca). La guía no fija la cantidad.
- **Paso de datos de C:** se instancia `DetalleCulturaViewController`, se le asigna la propiedad `cultura` y se hace `pushViewController` en un `UINavigationController`. Se eligió porque no hay Storyboard; con Storyboard sería un segue con `prepare(for:sender:)`.

## Interfaz de C

- Lista: celda propia `CulturaTableViewCell` con miniatura redondeada, nombre y región; títulos grandes de navegación.
- Detalle: imagen grande arriba, tarjeta con esquinas redondeadas, nombre en grande, región como etiqueta con icono, sección "Acerca de esta cultura" y texto con interlineado. Con scroll, Dynamic Type y colores del sistema (claro/oscuro).
- Archivos: `CulturaTableViewCell.swift`, `CulturasViewController.swift`, `DetalleCulturaViewController.swift`.

## Conclusiones (borrador)

1. `UITableView` necesita `dataSource` (cuántas filas y qué celda) y `delegate` (qué pasa al seleccionar); reutilizar celdas con `dequeueReusableCell` evita crear una vista por fila.
2. Una celda personalizada (`PersonasTableViewCell`) permite controlar el diseño de cada fila con sus propios outlets, más allá de los estilos predefinidos.
3. Para pasar datos entre pantallas se crea el controlador destino, se le asigna el modelo seleccionado y se navega con `UINavigationController`, así el detalle solo depende del dato recibido.
