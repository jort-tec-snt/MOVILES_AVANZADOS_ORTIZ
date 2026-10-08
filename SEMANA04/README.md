# Semana 04 — Programación Orientada a Objetos

El código **no está en `main`**: `main` solo guarda esta guía de navegación.
La semana tiene **dos tipos de trabajo**, cada uno en su propia rama.

| Tipo | Rama | Carpeta | Contenido |
|---|---|---|---|
| Manual (sin IA) | `manual` | `SEMANA04/Lab04-POO/` | Actividad 01 Cursos Libres, Actividad 02 Clientes (herencia), Caso 1.5 Sucursales (herencia y polimorfismo), Caso 2A Biblioteca |
| Con IA | `con-ia` | `SEMANA04/Lab04-P00/` | Caso 2B Biblioteca con IA (`BibliotecaIAComentada.swift` + `PROMPT.md`) |

> La carpeta se llama `Lab04-POO` en `manual` y `Lab04-P00` (con ceros) en `con-ia`. Es un nombre histórico.

## Ver el trabajo manual

```bash
git switch manual
cd SEMANA04/Lab04-POO
swift Caso2A_Biblioteca_Manual/BibliotecaManual.swift
```

## Ver el trabajo con IA

```bash
git switch con-ia
cd SEMANA04/Lab04-P00/Caso2B_Biblioteca_IA
swift BibliotecaIAComentada.swift
```

El prompt usado está en `PROMPT.md` de esa misma carpeta.

## Comparar sin cambiar de rama

```bash
git diff manual con-ia --stat -- SEMANA04
git show con-ia:SEMANA04/Lab04-P00/Caso2B_Biblioteca_IA/PROMPT.md
```

Volver a esta guía: `git switch main`.
