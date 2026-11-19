# PROMPTS.md · SEMANA 12 · Ventas con MVVM

Registro de las consultas a la IA, con el formato de la guía. **El estudiante debe completar "Qué hice con la respuesta".**

## Consulta 1 · Pasar el Grupo A a MVVM

- **Contexto:** app Ventas del Grupo A (UIKit + Core Data) ya resuelta en la SEMANA 11 con asistencia de IA. El docente pide el MVVM del Grupo A en la SEMANA 12.
- **Tarea:** "lo que hicimos debemos subirlo en la semana12, el MVVM pero del grupo A".
- **Restricciones:** mantener UIKit y Core Data, sin dependencias; misma funcionalidad que la SEMANA 11; entrega en la rama `con-ia` por tratarse de trabajo asistido.
- **Formato esperado:** proyecto Xcode en `SEMANA12/` que compile, con ViewModels separados de las vistas.
- **Qué hice con la respuesta:** *(completar: aceptada / modificada y por qué)*

**Resultado entregado por la IA:** proyecto `apple_lab12_Ventas_MVVM_UIKit_CoreData` con 10 ViewModels, vistas reducidas a UI, carpetas App/Modelo/Servicios/ViewModels/Views, `README.md` y este registro.

## Cómo se verificó

- Compilación con `xcodebuild` (BUILD SUCCEEDED).
- Búsqueda con `grep` de que `Views/` no contiene Core Data ni reglas de negocio.
- Prueba en el simulador de login, Resumen, Ventas y anulación con motivo, con consulta a la base (`../evidencias/sqlite-anulacion.txt`).
- Limitación: el flujo del vendedor y las pantallas de Productos y Clientes no se volvieron a ejercitar en pantalla tras el refactor.

## Para la defensa oral

Conviene poder explicar sin ayuda: qué responsabilidad tiene cada capa, cómo `onChange` conecta ViewModel y vista, por qué `Views/` no importa Core Data, y qué hace `VentasViewModel.anular(en:motivo:)`.

## Consulta 2 · Estructura visual en Main.storyboard

- **Contexto:** el docente no quiere la interfaz UIKit solo en código, sino visual (Storyboard).
- **Tarea:** "solo la estructura del UIKit, el Main.storyboard, eso necesito".
- **Restricciones:** no reescribir las vistas existentes; el storyboard debe compilar y mostrar la estructura y el flujo de la app.
- **Formato esperado:** `Main.storyboard` con las pantallas, las pestañas por rol y los *segues*.
- **Qué hice con la respuesta:** *(completar)*

**Resultado entregado por la IA:** `Storyboard/Main.storyboard` con 28 escenas, validado con `ibtool` y comprobado cargándolo en el simulador. No conecta las pantallas en ejecución con el storyboard (sin `IBOutlet`).
