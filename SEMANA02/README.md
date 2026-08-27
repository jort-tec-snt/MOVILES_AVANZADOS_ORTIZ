# 📚 Sistema de Gestión de Biblioteca - Historial de Co-Diseño (Prompt Engineering)

Este repositorio contiene la versión definitiva del sistema de control de préstamos y multas progresivas desarrollado en **Swift** desde la terminal de macOS. 

La arquitectura final es el resultado de un proceso interactivo de optimización de software guiado por ingeniería de prompts entre el estudiante y el asistente de IA.

---

## ⏱️ Línea de Tiempo del Desarrollo (Conversación y Prompts)

### 🧩 Fase 1: El Sistema Base y Manejo de Opcionales
* **Prompt del Usuario:** *"Tengo errores intentando sumar variables capturadas por consola. Swift me dice que el operador `+` no se puede aplicar a operandos `Double?`."*
* **Solución Técnica:** Se identificó la naturaleza segura de Swift con los opcionales de `readLine()`. Se implementó el operador de coalescencia nula `?? 0.0` para desenvolver las notas de manera segura y evitar fallas críticas por entradas vacías.

### 📅 Fase 2: Flexibilidad de Contratos y Filtro de Roles
* **Prompt del Usuario:** *"El sistema por defecto asume el tiempo máximo de tolerancia del usuario. ¿Qué pasa si un alumno pide un libro solo por 2 días y se atrasa? El límite debe ser dinámico basándose en los días solicitados, controlando que no pase el tope de su rol."*
* **Solución Técnica:** Se añadieron filtros dinámicos. El sistema valida los días solicitados frente a la tolerancia del tipo de usuario (`alumno`: 7d, `docente`: 15d, `administrativo`: 10d). Si se aprueba, la fecha límite se calcula estrictamente sumando los días elegidos por el usuario.

### 🔄 Fase 3: Resiliencia (Anti-Crash) y Menú Transaccional
* **Prompt del Usuario:** *"Cuando hay un error de tipeo en el rol o los días, el sistema ejecuta un `exit(1)` y me bota. Quiero que vuelva a preguntar sin cerrarse. Además, necesito registrar múltiples libros consecutivamente y que se almacenen en memoria."*
* **Solución Técnica:** 
  1. Se encapsularon los flujos de lectura en bucles interactivos `while true` que atrapan el error y exigen una entrada correcta para poder avanzar.
  2. Se modeló la estructura `struct Prestamo` junto con un arreglo dinámico para actuar como persistencia en memoria temporal, habilitando un menú interactivo con historial auditable.

### 🛡️ Fase 4: Blindaje Cronológico (El Bug del Pasado)
* **Prompt del Usuario:** *"Si pongo un año de 3 dígitos por error o pongo fechas del año 2002, el sistema genera desfases matemáticos masivos de cientos de días de atraso. El sistema debería reconocer que estamos en el año actual."*
* **Solución Técnica:** Se unificó el formato a 4 dígitos (`dd/MM/yyyy`) con la directiva estricta `formatter.isLenient = false`. Se enlazó el objeto `Date()` para extraer dinámicamente el año en curso (**2026**) bloqueando cualquier entrada fuera de época o cronológicamente invertida (devolución previa al préstamo).

---

## 🛠️ Especificaciones de la Lógica de Negocio Ejecutada

* **Multa Base:** S/. 1.50 por día.
* **Tramos Progresivos:**
  * Días 1 al 3 de atraso: Tarifa estándar (S/. 1.50).
  * Días 4 al 6 de atraso: +50% de recargo (S/. 2.25).
  * Días 7 a más de atraso: +100% de recargo (S/. 3.00).
* **Regla de Suspensión:** Traspasar la barrera de los 10 días de atraso conmuta automáticamente la condición del lector a `"Usuario suspendido"`.

---

## 🚀 Guía de Uso en la Terminal de macOS

### 1. Clonar o acceder a la carpeta del laboratorio
```bash
cd path/to/SEMANA02
```

### 2. Ejecutar el software interactivo
```bash
swift sistema-prestamos.swift
```

### 3. Historial de Commits sugeridos en la rama `sistema-prestamos`
Para documentar el flujo idéntico de la evolución en Git:
```bash
git add sistema-prestamos.swift
git commit -m "feat: implementar interfaz de ingreso de datos con validaciones while"

git add sistema-prestamos.swift
git commit -m "calc: procesar fechas límites en base a los días solicitados"

git add sistema-prestamos.swift
git commit -m "feat: blindar fechas con año actual de la Mac y añadir persistencia transaccional"
```
