# Registro de Prompts de Inteligencia Artificial - Semana 06

Este documento registra los prompts utilizados en el **Laboratorio 06: Gestión de vistas y navegación UIKit**, siguiendo la metodología académica de interacción asistida por IA.

---

## Estructura de Prompts

Cada prompt sigue el estándar establecido para el laboratorio:
1. **Contexto:** Estado de la aplicación y base tecnológica.
2. **Tarea:** Instrucción clara y objetivo técnico.
3. **Restricciones:** Límites técnicos y reglas de conservación de código.
4. **Formato:** Tipo de artefacto esperado (código, layout, documentación).
5. **Ejemplo:** Estructura o prompt específico enviado al modelo.
6. **Reflexión:** Análisis crítico de la intervención de la IA y decisiones del estudiante.

---

## Prompt 01 - Mejora visual UIKit

### Contexto
Aplicación funcional de laboratorio en la rama `con-ia` (evolucionada a partir de la base `manual`), desarrollada con **UIKit** y **Storyboard** para iOS 17+. El proyecto contiene un `UINavigationController`, navegación jerárquica tipo `Show` entre `ViewController` (Pantalla 1) y `ViewController2` (Pantalla 2), una presentación modal hacia `ViewControllerConfirmacion`, y el modelo de datos `ClienteModel`.

### Tarea
Revisar la interfaz de usuario existente y modernizar visualmente las pantallas, los controles de entrada, la jerarquía tipográfica, el espaciado y los constraints de Auto Layout, garantizando compatibilidad dinámica con los modos claro y oscuro (*Light Mode* y *Dark Mode*).

### Restricciones
- Conservar estrictamente **UIKit** y **Storyboard** (no utilizar SwiftUI).
- Mantener intactos todos los `@IBOutlet`, `@IBAction`, identificadores de segues, nombres de controladores y Storyboard IDs (`ViewControllerConfirmacion`).
- No modificar la lógica de transporte de datos de `ClienteModel` ni el flujo funcional de navegación.
- No agregar dependencias externas (CocoaPods, Swift Package Manager).
- No implementar animaciones complejas ni arquitecturas avanzadas ajenas al alcance del laboratorio.

### Formato
Edición declarativa en el archivo `Main.storyboard` utilizando componentes nativos (`UIStackView`, `UIScrollView`, tarjetas con esquinas redondeadas, SF Symbols y colores semánticos de sistema), acompañada de documentación descriptiva y validación de compilación mediante CLI (`xcodebuild`).

### Ejemplo
```text
Actúa como desarrollador senior iOS UIKit.
Revisa el archivo Main.storyboard de GLAB06.
Moderniza la interfaz de las 3 pantallas manteniendo exactamente los mismos IBOutlet, IBAction y Storyboard IDs.
Aplica UIStackView con espaciado consistente (16-24 pt), tarjetas contenedoras con fondo secondarySystemGroupedBackground y esquinas redondeadas de 12-14 pt, tipografía semántica (títulos en negrita y subtítulos en secondaryLabel), SF Symbols para iconos y campos de texto con altura mínima accesible de 48 pt.
Garantiza soporte completo para modo claro y oscuro usando colores semánticos del sistema.
```

### Reflexión
- **Qué realizó la IA:** Reorganizó las pantallas del registro de cliente, la segunda pantalla y el modal de confirmación implementando stacks verticales anidados, tarjetas visuales elevadas, iconos vectoriales del sistema (`person.crop.circle.fill`, `checkmark.seal.fill`) y campos de entrada con altura uniforme de 48 pt. Resolvió advertencias de Auto Layout y configuró paletas semánticas dinámicas.
- **Decisiones revisadas por el estudiante:** Se inspeccionó la legibilidad en simuladores con diferentes factores de forma (iPhone estándar vs modelos Max), se comprobó que el teclado no cubra los campos inferiores mediante el scroll interactivo y se verificó el contraste visual en modo oscuro antes de integrar el cambio.

---

## Prompt 02 - Calculadora de Venta a Plazos

### Contexto
Proyecto UIKit `GLAB06` en el contexto del **Ejercicio 4 (Venta a plazos)**. Se requiere incorporar un flujo comercial de venta a crédito que permita calcular el subtotal, el impuesto (IGV), la base, los intereses por financiamiento mensual, el monto total a pagar y el valor de cada cuota mensual para un electrodoméstico.

### Tarea
Implementar la solución completa del Ejercicio 4 asistida por IA:
1. Crear el modelo de datos `VentaModel` con propiedades numéricas para `subtotal`, `igv`, `base`, `intereses`, `total` y `cuota`.
2. Diseñar el controlador de entrada `NuevaVentaViewController` con campos para:
   - Nombre del electrodoméstico (`String`)
   - Precio unitario (`Double`)
   - Cantidad (`Int`)
   - Número de meses (`Int`)
   - Tasa de interés mensual en porcentaje (`Double`)
3. Programar las fórmulas de cálculo comercial:
   - $\text{Subtotal} = \text{precio} \times \text{cantidad}$
   - $\text{IGV} = \text{subtotal} \times 0.18$
   - $\text{Base} = \text{subtotal} + \text{IGV}$
   - $\text{Intereses} = \text{base} \times \left(\frac{\text{tasa}}{100}\right) \times \text{meses}$
   - $\text{Total} = \text{base} + \text{intereses}$
   - $\text{Cuota} = \frac{\text{total}}{\text{meses}}$
4. Implementar validación defensiva de datos mediante `guard let` y presentar alertas (`UIAlertController`) si los datos son inválidos o faltantes.
5. Configurar la navegación hacia `ResultadoVentaViewController` usando el segue `showResultado`, transfiriendo el modelo mediante `prepare(for:sender:)`.
6. Mostrar todos los importes calculados con formato monetario en Soles peruanos (`S/. %.2f`).

### Restricciones
- Usar únicamente UIKit, Storyboard y Swift estándar.
- No realizar desempaquetado forzado (`!`) en la lectura de campos ni en la conversión de texto a número.
- Garantizar que los valores numéricos de precio, cantidad y meses sean estrictamente mayores a cero, y la tasa de interés no sea negativa.
- Formatear la salida en moneda local (`S/. 0.00`).
- Mantener la separación de responsabilidades: modelo (`VentaModel`), controlador de captura (`NuevaVentaViewController`) y controlador de presentación (`ResultadoVentaViewController`).

### Formato
Archivos fuente en Swift (`VentaModel.swift`, `NuevaVentaViewController.swift`, `ResultadoVentaViewController.swift`), integración de escenas y segue `showResultado` en `Main.storyboard`, y verificación de compilación sin advertencias.

### Ejemplo
```text
Actúa como desarrollador iOS UIKit.
Implementa el Ejercicio 4 de la guía de laboratorio: Calculadora de Venta a Plazos.
1. Crea VentaModel como clase con subtotal, igv (18%), base, intereses, total y cuota.
2. Crea NuevaVentaViewController con IBOutlets para electrodoméstico, precio unitario, cantidad, meses y tasa de interés.
3. En la acción de calcular, valida con guard let que los campos no estén vacíos, que precio, cantidad y meses sean > 0 y la tasa >= 0. Si falla, muestra un UIAlertController informativo.
4. Calcula las fórmulas financieras e instancia VentaModel.
5. Conecta y ejecuta el segue con identificador "showResultado" pasando los datos mediante prepare(for:sender:).
6. Crea ResultadoVentaViewController con labels para mostrar cada valor formateado en Soles (ej. S/. 1,250.00).
```

### Reflexión
- **Estado de implementación:** *Pendiente de validación después de integrar el Ejercicio 4.*
- **Qué se encargó a la IA:** Generación estructurada del modelo `VentaModel`, controladores de vista con Auto Layout, validación rigurosa de entradas y transferencia de datos mediante segue `Show`.
- **Decisiones sujetas a revisión del estudiante:**
  - Verificación de la fórmula financiera según los lineamientos de la guía académica (orden de adición de IGV e interés mensual).
  - Manejo de coma decimal vs punto decimal en teclados numéricos (`replacingOccurrences(of: ",", with: ".")`).
  - Asegurar que la pantalla de resultado reciba el modelo no nulo y maneje de forma segura los valores antes de presentarlos.

---

## Reflexión sobre el uso de Inteligencia Artificial

### 1. ¿Qué realizó la IA?
La IA actuó como acelerador de desarrollo en dos frentes complementarios:
- En el **Prompt 01**, modernizó la interfaz visual de UIKit en `Main.storyboard`, creando jerarquías de `UIStackView`, configurando colores semánticos del sistema y aplicando estándares de diseño iOS sin romper conexiones previas.
- En el **Prompt 02**, se le encomendó la estructura del Ejercicio 4 (modelo `VentaModel`, controladores `NuevaVentaViewController` y `ResultadoVentaViewController`, cálculo de cuotas y configuración del segue `showResultado`).

### 2. ¿Qué decisiones fueron revisadas por el estudiante?
- **Validación visual y de experiencia de usuario (UX):** Comprobación en simulador de que los textos y títulos no se trunquen en pantallas pequeñas y que la vista se adapte con teclado visible.
- **Auditoría de fórmulas comerciales:** Verificación de que la tasa de interés se divida entre 100 y se multiplique por el número de meses, y que la cuota mensual resulte de la división exacta del total entre la cantidad de meses.
- **Compatibilidad con Storyboard:** Confirmación de que las clases personalizadas (*Custom Class*) y los Storyboard IDs coincidan exactamente con los archivos Swift creados.

### 3. ¿Se utilizó guard let?
Sí, en el diseño del flujo asistido por IA se estableció como regla obligatoria el uso de `guard let` tanto en la lectura y conversión de campos de texto como en la recepción del modelo en el controlador de resultados. Esto previene terminaciones abruptas (*crashes*) cuando el usuario deja campos vacíos o introduce caracteres alfanuméricos en campos de valor.

### 4. ¿Se agregaron validaciones?
Se definieron validaciones explícitas de negocio:
- Nombre del electrodoméstico no vacío tras eliminar espacios en blanco (`trimmingCharacters`).
- Precio unitario positivo y numérico finito.
- Cantidad entera estrictamente mayor a cero.
- Número de cuotas/meses entero estrictamente mayor a cero.
- Tasa de interés no negativa ($\ge 0$).
- Manejo de diálogo nativo de advertencia (`UIAlertController`) para guiar al usuario ante datos inconsistentes.

### 5. Diferencias entre solución manual y con IA
- **Velocidad de implementación:** La solución con IA genera esqueletos de controladores, modelos y configuraciones de Storyboard en una fracción del tiempo manual.
- **Calidad de interfaz inicial:** La IA tiende a estructurar interfaces más limpias y consistentes (márgenes uniformes, stacks y colores semánticos) frente a la colocación libre y dispersa de controles manuales.
- **Necesidad de supervisión crítica:** Mientras que en la solución manual el desarrollador comprende cada línea al escribirla, en la solución asistida por IA el desarrollador debe actuar como auditor de calidad, verificando que los nombres de los segues, los constraints y los cálculos matemáticos cumplan rigurosamente con la rúbrica académica.

> **Nota de estado:** Los resultados de ejecución correspondientes al Prompt 02 están marcados como:  
> **"Pendiente de validación después de integrar el Ejercicio 4."**
