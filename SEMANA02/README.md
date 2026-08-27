# 📘 Documento Explicativo: Sistema de Calificación Ponderada (Prueba de Clase)

Este documento detalla el análisis funcional, el proceso de diseño iterativo (Ingeniería de Prompts) y la arquitectura lógica del minisistema de notas desarrollado en **Swift CLI** como práctica de laboratorio.

---

## 🧠 1. Historial de Prompts Utilizados (Proceso de Co-Diseño)

El script actual se consolidó resolviendo vacíos lógicos y errores de compilación típicos del lenguaje Swift mediante un flujo de preguntas y respuestas:

### 📥 Iteración 1: El Problema de los Valores Opcionales (Nil)
* **Prompt Guía:** *"Tengo un error al intentar sumar las notas ingresadas por consola. Swift me indica un fallo de compilación que dice: `binary operator '+' cannot be applied to two 'Double?' operands`."*
* **Impacto Funcional:** Se identificó que la función `readLine()` devuelve un valor opcional (puede ser nulo si el usuario solo presiona Enter o escribe letras). Se aplicó el operador de coalescencia nula `?? 0.0` inmediatamente después de la conversión a `Double`. Esto forzó al sistema a asignar un cero por defecto en lugar de colapsar (*crash*).

### 🔤 Iteración 2: El Error de Ámbito (Scope Error)
* **Prompt Guía:** *"Modifiqué el código pero ahora la terminal me arroja un mensaje de error: `cannot find 'exParcial' in scope` en la línea donde realizo la multiplicación."*
* **Impacto Funcional:** Se analizó el caso sensitivo de Swift (mayúsculas y minúsculas). Se homologaron las variables de entrada (`exParcial`, `exTrabajo`, `exFinal`) asegurando que la declaración en el Bloque 1 coincidiera con la fórmula matemática del Bloque 2.

### 📐 Iteración 3: Redondeo Técnico de Decimales
* **Prompt Guía:** *"Cuando el promedio da un número periódico o con muchos decimales (por ejemplo, 14.3333333), la consola se ve desordenada. ¿Cómo lo limito a solo dos decimales?"*
* **Impacto Funcional:** Se reemplazó la impresión directa de la variable por la función estructurada `String(format: "%.2f", notaFinal)`. Esto garantizó un reporte limpio y estandarizado para la entrega de notas.

---

## ⚙️ 2. Explicación Funcional del Código

El script opera de manera lineal y eficiente a través de tres bloques de control:

### A. Constantes de Configuración (Sistema de Pesos)
```swift
let parcial = 0.3
let trabajo = 0.3
let final = 0.4
```
* **Función:** Establece las reglas académicas del curso de forma inmutable (`let`). Centralizar los pesos aquí permite que si la institución decide cambiar el valor del examen final al 50%, solo se deba modificar una línea de código sin alterar la fórmula general.

### B. Bloque 1: Captura e Inyección Segura de Datos
* **Función:** Utiliza `readLine()` de forma sucesiva para congelar la terminal y esperar el ingreso del usuario. La anidación `Double(readLine() ?? "") ?? 0.0` actúa como un doble escudo de seguridad: limpia el opcional del teclado y luego limpia el opcional de la conversión numérica.

### C. Bloque 2: Procesamiento Matemático y Lógica Condicional
```swift
let notaFinal = (exParcial * parcial) + (exTrabajo * trabajo) + (exFinal * final)
let estado = notaFinal >= 10.5 ? "Aprobado" : "Desaprobado"
```
* **Fórmula:** Ejecuta la suma del producto de cada nota por su respectivo porcentaje de peso.
* **Operador Ternario (`? :`):** Reemplaza una estructura pesada de `if-else`. En una sola línea, evalúa si la nota es igual o mayor a `10.5` (nota mínima aprobatoria común) para asignar de forma inmediata el texto "Aprobado" o "Desaprobado" a la constante `estado`.

### D. Bloque 3: Interfaz de Salida (Reporte)
* **Función:** Imprime el reporte final con una separación estética (`\n`). Al formatear el promedio con `"%.2f"`, el sistema trunca y redondea automáticamente el valor, entregando un entregable limpio y legible para el alumno.

