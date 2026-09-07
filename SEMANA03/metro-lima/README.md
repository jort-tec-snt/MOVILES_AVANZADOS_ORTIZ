# 🚇 Simulador de la Red del Metro de Lima

Aplicación de consola desarrollada en **Swift** para simular consultas sobre una red mock del Metro de Lima.

El proyecto aplica estructuras de datos, colecciones y control de flujo mediante `Struct`, `Array`, `Dictionary`, `Set`, funciones y entrada de datos desde consola.

---

## 📌 Funcionalidades

| ID       | Requerimiento            | Descripción                                                                                  |
| -------- | ------------------------ | -------------------------------------------------------------------------------------------- |
| **RF01** | Catálogo General         | Muestra las líneas registradas, origen, destino, estado y cantidad de estaciones.            |
| **RF02** | Detalle de Estaciones    | Permite seleccionar una línea y listar secuencialmente sus estaciones.                       |
| **RF03** | Detección de Transbordos | Identifica estaciones compartidas entre líneas mediante operaciones con `Set`.               |
| **RF04** | Asistente de Ruta        | Genera una ruta desde la Línea 2 hacia el Estadio Nacional mediante conexión con la Línea 3. |
| **RF05** | Búsqueda Global          | Busca estaciones por nombre o coincidencia parcial dentro de toda la red.                    |

---

## 🧱 Modelo de Datos

El sistema utiliza dos estructuras principales:

```swift
struct Estacion {
    let nombre: String
    let ubicacion: String
    let latitud: Double
    let longitud: Double
}

struct LineaMetro {
    let codigo: String
    let nombre: String
    let estado: String
    let origen: String
    let destino: String
    let estaciones: [Estacion]
}
```

La red completa se almacena mediante:

```swift
[String: LineaMetro]
```

---

## 🗃️ Red Mock

Actualmente se modelan seis líneas:

```text
L1 — Línea 1 (Verde)
L2 — Línea 2 (Amarilla)
L3 — Línea 3 (Cian)
L4 — Línea 4 (Roja)
L5 — Línea 5 (Magenta)
L6 — Línea 6 (Naranja)
```

Cada estación contiene:

```text
nombre
ubicación
latitud
longitud
```

> Los datos forman parte de una representación académica utilizada para el funcionamiento del simulador.

---

## 🔄 Colecciones utilizadas

### Dictionary

Almacena las líneas de la red:

```swift
let redMetro: [String: LineaMetro]
```

### Array

Mantiene las estaciones de cada línea en orden:

```swift
[Estacion]
```

### Set

Permite encontrar estaciones compartidas entre líneas:

```swift
let estacionesA = Set(lineaA.estaciones.map { $0.nombre })
let estacionesB = Set(lineaB.estaciones.map { $0.nombre })

let intersecciones = estacionesA.intersection(estacionesB)
```

---

## 🖥️ Menú CLI

El sistema integra los requerimientos mediante un menú interactivo:

```text
==================================================
       SIMULADOR DE RED - METRO DE LIMA
==================================================

1) [RF01] Ver catálogo general de líneas
2) [RF02] Consultar estaciones por línea
3) [RF03] Ver puntos de transbordo
4) [RF04] Asistente de ruta al Estadio Nacional
5) [RF05] Búsqueda global de estaciones
6) Salir
```

---

## 🏗️ Estructura

```text
metro-lima/
│
├── metro-lima.swift
│   │
│   ├── Modelos de datos
│   ├── Base de datos mock
│   ├── RF01
│   ├── RF02
│   ├── RF03
│   ├── RF04
│   ├── RF05
│   └── Menú CLI
│
└── README.md
```

---

## ▶️ Ejecución

Desde la carpeta del proyecto:

```bash
swift metro-lima.swift
```

También puede compilarse como ejecutable:

```bash
swiftc metro-lima.swift -o metro-lima
```

Y ejecutarse mediante:

```bash
./metro-lima
```

---

## 🛠️ Tecnologías

* Swift
* Foundation
* CLI
* Git
* GitHub

### Conceptos aplicados

* `Struct`
* `Array`
* `Dictionary`
* `Set`
* `map`
* `sorted`
* ciclos
* condicionales
* funciones
* `readLine()`
* búsqueda de elementos
* operaciones entre conjuntos

---

## 🎓 Contexto Académico

Proyecto desarrollado para el curso **Programación en Móviles Avanzado**, aplicando colecciones, estructuras de datos, control de flujo y programación funcional básica mediante Swift.
