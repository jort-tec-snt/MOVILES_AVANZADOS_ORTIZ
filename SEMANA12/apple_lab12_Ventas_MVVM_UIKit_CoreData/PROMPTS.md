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
