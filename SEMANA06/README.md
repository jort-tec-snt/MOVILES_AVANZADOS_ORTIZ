# Semana 06 - Gestión de vistas y navegación UIKit

## Objetivo

Practicar la gestión de vistas y los diferentes tipos de navegación en una aplicación iOS académica construida con **UIKit** y **Storyboard**. El laboratorio abarca la navegación jerárquica, la captura de datos con paso de parámetros entre controladores, la presentación modal y el desarrollo de una calculadora comercial de venta a plazos asistida por IA.

---

## Diferenciación entre Ramas

El proyecto se encuentra organizado en dos ramas de trabajo para evidenciar el proceso de desarrollo:

### 1. Rama `manual`
Representa el desarrollo tradicional paso a paso en Xcode:
- **Navegación jerárquica base:** Implementación de un `UINavigationController` con segue de tipo `Show` para transicionar entre la Pantalla 1 (`ViewController`) y la Pantalla 2 (`ViewController2`).
- **Modelo de datos `ClienteModel`:** Clase encargada de encapsular los atributos del cliente (`codigo`, `apellido`, `nombre` y `dni`).
- **Formulario y paso de datos:** Captura de datos personales en `ViewController`.
- **Modal de confirmación:** Presentación modal programática (`present(_:animated:)`) hacia `ViewControllerConfirmacion` para revisar los datos registrados.

### 2. Rama `con-ia`
Representa la evolución del proyecto mediante asistencia de Inteligencia Artificial:
- **Mejora visual UIKit (Prompt 01):** Reorganización estética de las pantallas existentes con `UIStackView`, tarjetas con esquinas redondeadas, jerarquía tipográfica, iconos SF Symbols y colores semánticos (`systemGroupedBackground`, `secondarySystemGroupedBackground`) compatibles con los modos claro y oscuro.
- **Ejercicio 4 asistido por IA - Calculadora de Venta a Plazos:**
  - **Estado:** Integrado en `con-ia` y compilado para iOS Simulator.
  - **Modelo `VentaModel`:** Clase para almacenar y transferir `subtotal`, `igv`, `base`, `intereses`, `total` y `cuota`.
  - **Pantalla Nueva Venta (`NuevaVentaViewController`):** Captura de electrodoméstico, precio unitario, cantidad, meses e interés con validaciones defensivas (`guard let`) y alertas (`UIAlertController`).
  - **Navegación con paso de datos (`showResultado`):** Segue de tipo `Show` que transfiere la información mediante `prepare(for:sender:)`.
  - **Pantalla Resultado (`ResultadoVentaViewController`):** Desglose ordenado de importes formateados en Soles peruanos (`S/. %.2f`).

---

## Tabla comparativa: manual vs con-ia

| Aspecto | Rama `manual` | Rama `con-ia` |
|---|---|---|
| **Navegación base** | `UINavigationController`, segue `Show` y presentación modal | Mantiene el flujo existente y suma navegación para Ejercicio 4 |
| **Diseño visual** | Controles y etiquetas con distribución básica | Stacks anidados, tarjetas elevadas, SF Symbols y soporte light/dark |
| **Formulario cliente** | Campos estándar con separación manual | Tarjeta visual con espaciado consistente y campos de 48 pt |
| **Modal confirmación** | Título y etiquetas de texto simples | Encabezado estilizado con tarjeta de resumen destacada |
| **Ejercicio 4 (Calculadora)** | No implementado en la rama manual | Integrado: VentaModel, Nueva Venta y Resultado |
| **Validaciones** | Conversión directa de cadenas a texto | Validación estructurada con `guard let` y `UIAlertController` |
| **Paso de parámetros** | Instanciación manual con `instantiateViewController` | Combinación de presentación modal y `prepare(for:sender:)` |
| **Rol del desarrollador** | Codificación y diseño manual integral | Arquitecto, formulador de prompts y auditor de código |

---

## Conclusiones e Investigación Teórica

### 1. ¿Cuándo conviene Show y cuándo Present Modally?

- **Show (Push):**
  - **Cuándo conviene:** Se utiliza cuando la pantalla que se va a abrir forma parte natural y jerárquica del mismo flujo de navegación. El usuario profundiza en un tema o avanza en un proceso paso a paso, esperando mantener visible la barra de navegación superior y contar con el botón de retroceso (**< Back**) o el gesto de deslizamiento para volver atrás.
  - **Ejemplo real:** En la aplicación **WhatsApp** o **Mensajes**, cuando se toca una conversación de la lista principal para abrir la pantalla de chat con esa persona.
- **Present Modally:**
  - **Cuándo conviene:** Se utiliza cuando se interrumpe temporalmente el flujo principal para que el usuario complete una tarea autónoma, tome una decisión puntual o ingrese información crítica antes de volver a la vista anterior. Generalmente cubre la pantalla o aparece como una tarjeta inferior (*sheet*) que debe descartarse explícitamente mediante botones como "Guardar", "Aceptar" o "Cancelar".
  - **Ejemplo real:** En la aplicación **Mail**, presionar el botón de redactar para abrir la ventana modal de "Nuevo Correo"; o al escanear un código QR para realizar un pago bancario.

### 2. ¿Para qué sirven Show Detail y Present As Popover y en qué dispositivos tienen sentido?

- **Show Detail (Replace):**
  - **Para qué sirve:** Está pensado para arquitecturas con vistas divididas (`UISplitViewController`). En vez de apilar una pantalla encima de otra como en un *push*, reemplaza el contenido del panel secundario o de detalle (derecha), manteniendo fija y accesible la lista o menú maestro (izquierda).
  - **Dispositivos en los que tiene sentido:** Tiene sentido sobre todo en **iPad** y **Mac** con interfaz de paneles. En iPhone, su presentación se adapta al espacio disponible y puede comportarse como navegación jerárquica.
- **Present As Popover:**
  - **Para qué sirve:** Muestra una pequeña vista flotante con una flecha contextual que apunta de manera directa al botón o elemento visual que originó la acción, sin oscurecer toda la pantalla ni bloquear completamente el entorno.
  - **Dispositivos en los que tiene sentido:** Tiene sentido pleno en **iPad** y **Mac**, donde existe suficiente espacio en pantalla para mostrar menús contextuales, paletas de herramientas o selectores de fecha. En **iPhone**, UIKit puede adaptar la presentación a una modalidad más apropiada para la pantalla compacta.

### 3. ¿Qué ocurriría si ClienteModel o VentaModel fueran struct en vez de class? ¿Se rompería el paso de datos hacia adelante?

- **Respuesta:** **No, el paso de datos hacia adelante no se rompería en absoluto.**
- **Explicación técnica:**
  En Swift, tanto las `class` (tipos por referencia) como los `struct` (tipos por valor) permiten almacenar datos y transferirse entre controladores. Cuando se pasa un `struct` desde el controlador emisor hacia el controlador receptor (por ejemplo, asignándolo a la propiedad `destinationVC.venta = miVenta` en `prepare(for:sender:)`), Swift crea una **copia exacta e independiente** de la estructura. El controlador de destino recibe todos los valores calculados (`subtotal`, `igv`, `cuota`, etc.) y los muestra en pantalla sin ningún inconveniente.
- **Diferencia práctica:**
  La diferencia radica en que, al ser un tipo por valor, si la pantalla receptora modificara alguna propiedad de esa copia, el cambio no afectaría al objeto original de la pantalla emisora. Habría que retirar la herencia de `NSObject` y adaptar cualquier código que dependiera de identidad de referencia; la asignación del modelo al controlador de destino seguiría funcionando.

### 4. ¿Qué diferencia existe entre resolver el Ejercicio 2 manual y el Ejercicio 4 con IA en tiempo y comprensión?

- **En tiempo:**
  - El **Ejercicio 2 manual** exige colocar controles en el Storyboard, conectar `@IBOutlet` y `@IBAction`, resolver constraints y escribir el transporte de datos con `ClienteModel`.
  - En el **Ejercicio 4 asistido por IA**, la generación inicial de clases, fórmulas y escenas puede ahorrar tiempo de escritura, pero requiere tiempo de revisión e integración. No se registraron tiempos medidos para comparar ambos ejercicios.
- **En comprensión:**
  - La resolución manual brindó una **comprensión granular y práctica** sobre cómo se interconectan los elementos visuales con el código fuente y cómo funciona el ciclo de vida del controlador en UIKit.
  - El desarrollo con IA trasladó el esfuerzo del estudiante desde la sintaxis hacia la **auditoría y la arquitectura**: requirió entender a fondo los conceptos teóricos para escribir un prompt preciso, fiscalizar la exactitud de las fórmulas matemáticas, verificar que las validaciones con `guard let` fuesen robustas y asegurarse de que el segue y los identificadores en el Storyboard estuvieran correctamente vinculados.

---

## Ejecución y Pruebas por CLI

La compilación de `con-ia` se verificó con `** BUILD SUCCEEDED **`. El caso de control con Laptop, S/. 3500, cantidad 1, 12 meses e interés mensual de 1 % produce subtotal S/. 3500.00, IGV S/. 630.00, base S/. 4130.00, intereses S/. 495.60, total S/. 4625.60 y cuota S/. 385.47.

El catálogo `AppIcon.appiconset` existe, pero solo contiene la plantilla sin archivo de imagen. Queda pendiente proporcionar un icono personalizado; no se incluyó uno artificial.

Para compilar y verificar el proyecto desde la terminal utilizando las herramientas de línea de comandos de Xcode:

```bash
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer

# Compilación para el simulador de iOS
xcodebuild \
  -project SEMANA06/GLAB06/GLAB06.xcodeproj \
  -scheme GLAB06 \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/GLAB06DerivedData \
  build

# Instalación y ejecución en simulador local (sustituir <device-udid>)
xcrun simctl install <device-udid> /tmp/GLAB06DerivedData/Build/Products/Debug-iphonesimulator/GLAB06.app
xcrun simctl launch <device-udid> pe.edu.tecsup.GLAB06
```

Para abrir la utilidad de dispositivos en Xcode 27:

```bash
open -b com.apple.dt.Devices
```

---

## Documentos Relacionados

- [Registro de Prompts de IA](PROMPTS.md): Registro detallado de prompts, restricciones, tareas y reflexiones del laboratorio.
- [Checklist de Entrega y Verificación](ENTREGA.md): Estado verificado de requisitos y pendientes reales.
