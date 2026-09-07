# 📚 Semana 03 — Programación en Móviles Avanzado

Durante la **Semana 03** se trabajó con colecciones y estructuras de datos en Swift, aplicándolas en un simulador de consultas para la Red del Metro de Lima.

Los principales conceptos utilizados fueron:

* `Struct`
* `Array`
* `Dictionary`
* `Set`
* `map`
* `sorted`
* `enumerated`
* ciclos
* condicionales
* funciones
* `readLine()`
* navegación mediante CLI

---

## 🚇 Proyecto desarrollado

### Simulador de la Red del Metro de Lima

Aplicación de consola desarrollada en **Swift** que representa una red mock del Metro de Lima y permite realizar diferentes consultas mediante un menú interactivo.

El simulador incluye los siguientes requerimientos funcionales:

| ID       | Funcionalidad                               |
| -------- | ------------------------------------------- |
| **RF01** | Catálogo general de líneas                  |
| **RF02** | Consulta de estaciones por línea            |
| **RF03** | Detección de transbordos mediante `Set`     |
| **RF04** | Asistente de ruta hacia el Estadio Nacional |
| **RF05** | Búsqueda global de estaciones               |

---

# 🌿 Ubicación del Simulador

El código completo del simulador se encuentra en la rama:

```text
home
```

Dentro de la carpeta:

```text
metro-lima/
```

El archivo principal es:

```text
metro-lima.swift
```

---

# 🔀 Cambiar a la rama del proyecto

Desde el repositorio:

```bash
git switch home
```

También puede utilizarse:

```bash
git checkout home
```

Verificar la rama actual:

```bash
git branch
```

Debe aparecer:

```text
* home
```

---

# 📂 Acceder al proyecto

Ingresar a la carpeta:

```bash
cd metro-lima
```

Comprobar su contenido:

```bash
ls
```

La estructura esperada es:

```text
metro-lima/
│
├── metro-lima.swift
└── README.md
```

---

# ▶️ Ejecutar el simulador

Puede ejecutarse directamente con Swift:

```bash
swift metro-lima.swift
```

Al iniciar aparecerá el menú:

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

# 🛠️ Compilación opcional

También puede compilarse como ejecutable:

```bash
swiftc metro-lima.swift -o metro-lima
```

Posteriormente:

```bash
./metro-lima
```

---

# 🧱 Organización del código

El proyecto se mantiene en un único archivo Swift debido al alcance del prototipo, pero está organizado lógicamente en diferentes secciones:

```text
metro-lima.swift
│
├── Modelos de datos
│   ├── Estacion
│   └── LineaMetro
│
├── Base de datos mock
│   └── redMetro L1-L6
│
├── Requerimientos funcionales
│   ├── RF01
│   ├── RF02
│   ├── RF03
│   ├── RF04
│   └── RF05
│
└── Navegación CLI
```

---

# 📌 Resumen de navegación

```text
Repositorio
│
├── rama main
│   │
│   └── Documentación general de SEMANA03
│
└── rama home
    │
    └── metro-lima/
        │
        ├── metro-lima.swift
        └── README.md
```

Para acceder rápidamente:

```bash
git switch home
cd metro-lima
swift metro-lima.swift
```

---

## 🎓 Contexto

Proyecto desarrollado durante la **Semana 03 del curso Programación en Móviles Avanzado**, con el objetivo de aplicar colecciones, estructuras de datos, control de flujo y funciones en Swift mediante un caso práctico.

