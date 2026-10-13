# SEMANA 07 – GLAB-S07 Manejo de Datos: Tablas y Colecciones (UIKit)

| Parte | Proyecto | Qué muestra |
|---|---|---|
| A | `GLAB07A_Profesores` | `UITableView` con celda `"celda"` (estilo Subtitle), clase `Profesor` (nombre, cargo, foto), `dequeueReusableCell` |
| B | `GLAB07B_Personas` | Celda personalizada `PersonasTableViewCell` (imagen + label) y alerta en `didSelectRowAt` |
| C | `GLAB07C_Culturas` | Lista de 6 culturas peruanas → detalle (nombre, región, descripción, imagen) |

Abrir: `open SEMANA07/<proyecto>/<proyecto>.xcodeproj`

## Decisiones

- **UI por código, sin Storyboard.** Editar el `.storyboard` a mano es frágil; los pasos de la guía (Table View, constraints, identifier, Subtitle, dataSource/delegate, outlets) están hechos en código con el mismo resultado.
- **Un proyecto por ejercicio** (la guía crea otra aplicación para la parte B).
- **Propiedad `cargo`** en `Profesor`, como en la guía; se muestra como subtítulo.
- **Imágenes:** placeholders (círculo de color + SF Symbol) generados y guardados en Assets. No se descargó nada. Se pueden reemplazar por fotos reales manteniendo el nombre del imageset.
- **Culturas:** 6 (Caral, Chavín, Paracas, Nazca, Moche, Inca). La guía no fija la cantidad.
- **Paso de datos de C:** se instancia `DetalleCulturaViewController`, se le asigna la propiedad `cultura` y se hace `pushViewController` en un `UINavigationController`. Se eligió porque no hay Storyboard; con Storyboard sería un segue con `prepare(for:sender:)`.

## Conclusiones (borrador)

1. `UITableView` necesita `dataSource` (cuántas filas y qué celda) y `delegate` (qué pasa al seleccionar); reutilizar celdas con `dequeueReusableCell` evita crear una vista por fila.
2. Una celda personalizada (`PersonasTableViewCell`) permite controlar el diseño de cada fila con sus propios outlets, más allá de los estilos predefinidos.
3. Para pasar datos entre pantallas se crea el controlador destino, se le asigna el modelo seleccionado y se navega con `UINavigationController`, así el detalle solo depende del dato recibido.
