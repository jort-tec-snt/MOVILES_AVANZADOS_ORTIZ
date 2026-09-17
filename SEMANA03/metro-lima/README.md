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
| **RF04** | Asistente de Ruta        | Calcula recorridos entre estaciones de una misma línea o de líneas diferentes, detectando transbordos, mostrando el trayecto y contabilizando las estaciones restantes. |
| **RF05** | Búsqueda Global          | Busca estaciones por nombre o coincidencia parcial dentro de toda la red.                    |
| **RF06** | Gestión de Tarjeta de Transporte | Permite consultar el estado y saldo de una tarjeta simulada y realizar recargas durante la ejecución del sistema. |
| **RF07** | Información y Referencias de Estación | Permite consultar la ubicación, coordenadas y referencias cercanas registradas de una estación de la red. |
| **RF08** | Modo Administrador y Expansión de Red | Permite agregar e insertar estaciones, crear nuevas líneas y simular dinámicamente el crecimiento de la Red del Metro durante la ejecución. |
| **RF09** | Simulación de Viaje y Pago con Tarjeta | Permite calcular un recorrido utilizando la red actual, consultar el estado y saldo de la tarjeta, confirmar el viaje y descontar una tarifa simulada. |

Para recorridos entre líneas, RF04 utiliza búsqueda en anchura (BFS) sobre las estaciones y sus conexiones de transbordo.

Los cambios realizados desde RF08 son temporales durante la sesión. Las funciones de consulta y rutas utilizan inmediatamente la red actualizada.

La tarifa utilizada por RF09 es un valor simulado con fines académicos y no representa necesariamente la tarifa oficial del servicio.

---

## 🧱 Modelo de Datos

El sistema utiliza dos estructuras principales:

```swift
struct Estacion {
    let nombre: String
    let ubicacion: String
    let latitud: Double
    let longitud: Double
    let referencias: [String]
}

struct LineaMetro {
    let codigo: String
    var nombre: String
    var estado: String
    var origen: String
    var destino: String
    var estaciones: [Estacion]
}
```

La red completa se almacena mediante:

```swift
[String: LineaMetro]
```

---

## 🗃️ Red Mock

Inicialmente se modelan seis líneas:

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
referencias
```

> Los datos forman parte de una representación académica utilizada para el funcionamiento del simulador.

---

## 🔄 Colecciones utilizadas

### Dictionary

Almacena las líneas de la red:

```swift
var redMetro: [String: LineaMetro]
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
4) [RF04] Asistente de ruta entre estaciones
5) [RF05] Búsqueda global de estaciones
6) [RF06] Gestión de tarjeta de transporte
7) [RF07] Información y referencias de estación
8) [RF08] Modo administrador
9) [RF09] Simular viaje y pagar con tarjeta
10) Salir
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
│   ├── RF06
│   ├── RF07
│   ├── RF08
│   ├── RF09
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
