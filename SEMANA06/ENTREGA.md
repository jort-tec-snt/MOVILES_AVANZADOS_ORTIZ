# Control de Entrega y Verificación - Semana 06

**Asignatura:** Desarrollo de Aplicaciones Móviles Avanzado  
**Institución:** TECSUP  
**Laboratorio:** 06 - Gestión de vistas y navegación UIKit  
**Rama de trabajo:** `agent/antigravity-docs`  
**Rol:** Arquitecto de documentación y QA  

---

## Checklist de Requisitos

A continuación se presenta la lista de verificación oficial del laboratorio. Siguiendo las directrices de aseguramiento de calidad, **únicamente se marcan como completados aquellos elementos que han sido formalmente verificados** en la rama actual.

- [x] UIKit + Storyboard
- [ ] App Icon
- [x] UINavigationController
- [x] Pantalla 1
- [x] Pantalla 2
- [x] navegación Show
- [x] investigación Show
- [x] investigación Show Detail
- [x] investigación Present Modally
- [x] investigación Present As Popover
- [x] ClienteModel
- [x] formulario cliente
- [x] modal confirmación
- [ ] Nueva Venta
- [ ] VentaModel
- [ ] Resultado
- [ ] showResultado
- [ ] prepare(for:sender:)
- [ ] formato soles
- [x] PROMPTS.md
- [x] conclusiones
- [x] build exitoso
- [ ] capturas
- [ ] commit requerido
- [ ] push

---

## Estado Detallado de Verificación

### Elementos Verificados `[x]`
1. **UIKit + Storyboard:** Verificado. Proyecto configurado en Xcode con `Main.storyboard` y controladores UIKit nativos.
2. **UINavigationController:** Verificado. Identificador `nav-01-main` en `Main.storyboard` como controlador raíz de navegación.
3. **Pantalla 1 y Pantalla 2:** Verificado. `ViewController` (`vc-screen-01`) y `ViewController2` (`vc-screen-02`) creados y enlazados.
4. **Navegación Show:** Verificado. Segue de tipo `Show` (`segue-screen-01-to-02`) con navegación jerárquica activa.
5. **Investigaciones técnicas (Show, Show Detail, Present Modally, Present As Popover):** Verificado. Respuestas fundamentadas y detalladas en `README.md` y en este documento.
6. **ClienteModel:** Verificado. Archivo `ClienteModel.swift` con propiedades `codigo`, `apellido`, `nombre` y `dni`.
7. **Formulario cliente:** Verificado. Campos de texto y botón continuar implementados en `ViewController`.
8. **Modal confirmación:** Verificado. Presentación modal funcional hacia `ViewControllerConfirmacion`.
9. **PROMPTS.md:** Verificado. Documentación completa con estructura *Contexto, Tarea, Restricciones, Formato, Ejemplo y Reflexión* para Prompt 01 y Prompt 02.
10. **Conclusiones:** Verificado. 4 preguntas resueltas con lenguaje académico claro y conciso.
11. **Build exitoso:** Verificado mediante ejecución CLI de `xcodebuild` con salida `** BUILD SUCCEEDED **`.

### Elementos No Marcados / Pendientes de Verificación `[ ]`
1. **App Icon:** La carpeta `Assets.xcassets/AppIcon.appiconset` contiene únicamente la plantilla por defecto sin imagen de 1024x1024 px.
2. **Nueva Venta, VentaModel, Resultado, showResultado, prepare(for:sender:) y formato soles:**  
   - **Estado:** *En implementación*.  
   - **Observación:** El Ejercicio 4 está siendo desarrollado por el agente Codex de forma concurrente en la rama `agent/codex-ej4`. En la rama actual de documentación aún no se ha integrado el código fuente correspondiente; por tanto, se mantiene sin marcar conforme a la regla de no asumir resultados no verificados.
3. **Capturas:** Pendientes de generación y archivo una vez se integre y ejecute la aplicación completa con el Ejercicio 4 en el simulador.
4. **Commit requerido:** Pendiente de ejecución en el paso de cierre de esta tarea de documentación.
5. **Push:** Pendiente por indicación expresa del protocolo de trabajo (*no realizar push*).

---

## Respuestas Académicas a las Preguntas de Conclusión

### 1. ¿Cuándo conviene Show y cuándo Present Modally?
- **Show (Push):** Conviene cuando la nueva pantalla es parte natural de la secuencia o jerarquía de la app, permitiendo navegar hacia adelante y volver hacia atrás manteniendo visible la barra de navegación (**< Back**).  
  *Ejemplo real:* En **WhatsApp** o **Instagram**, tocar una conversación o un usuario para ver su detalle o chat.
- **Present Modally:** Conviene cuando se abre una pantalla temporal e independiente para que el usuario complete una tarea puntual (ingresar datos, confirmar una orden o modificar ajustes) antes de regresar al flujo principal, cerrándose con botones específicos como "Cerrar" o "Cancelar".  
  *Ejemplo real:* En **Mail**, presionar el botón de redactar para abrir la ventana modal de un nuevo mensaje.

### 2. ¿Para qué sirven Show Detail y Present As Popover y en qué dispositivos tienen sentido?
- **Show Detail (Replace):** Sirve para reemplazar el panel de detalle secundario en controladores de pantalla dividida (`UISplitViewController`).  
  *Dispositivos:* Tiene sentido en dispositivos con pantalla grande como **iPad** y **Mac**, o en **iPhone en posición horizontal (Landscape)** en versiones Plus o Max. En un iPhone vertical convencional, se adapta actuando como un `Show` estándar.
- **Present As Popover:** Muestra una ventana contextual flotante con una flecha dirigida al elemento que la activó, sin bloquear toda la pantalla.  
  *Dispositivos:* Tiene sentido en **iPad** y **Mac** donde hay espacio suficiente para ventanas flotantes. En **iPhone**, UIKit lo convierte por defecto en una vista modal de pantalla completa o *sheet* inferior.

### 3. ¿Qué ocurriría si ClienteModel o VentaModel fueran struct en vez de class? ¿Se rompería el paso de datos hacia adelante?
- **No se rompería el paso de datos hacia adelante.**  
- **Explicación:** En Swift, un `struct` pasa datos por valor (crea una copia independiente). Cuando el controlador emisor asigna el modelo a la propiedad del controlador receptor en `prepare(for:sender:)`, este último recibe una copia íntegra con todos los valores (`subtotal`, `total`, `cuota`) y los muestra correctamente. La única diferencia es que modificaciones posteriores en la pantalla receptora no afectarían al objeto emisor. De hecho, el uso de `struct` es la convención idiomática preferida en Swift por seguridad y ligereza.

### 4. ¿Qué diferencia existe entre resolver el Ejercicio 2 manual y el Ejercicio 4 con IA en tiempo y comprensión?
- **En tiempo:** La solución manual requirió más tiempo al tener que colocar controles en el Storyboard, conectar outlets a mano y escribir la lógica básica. La solución con IA del Ejercicio 4 ahorró tiempo generando de forma casi instantánea las clases, validaciones con `guard let`, cálculos financieros y plantillas de vista.
- **En comprensión:** La solución manual afianza las bases del lenguaje, el ciclo de vida de los controladores y la relación visual con Storyboard. La solución con IA enseña a auditar código, formular especificaciones rigurosas y verificar críticamente que los cálculos matemáticos y las validaciones defensivas cumplan los requisitos.
