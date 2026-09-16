import Foundation

// MARK: - Estado del libro

enum EstadoLibro: String {
    case disponible = "DISPONIBLE"
    case prestado = "PRESTADO"
}


// MARK: - Modelo Libro

struct Libro {
    let titulo: String
    let autor: String
    var estado: EstadoLibro = .disponible
}


// MARK: - Gestión de Biblioteca

class Biblioteca {

    private var libros: [Libro] = []

    // Agregar libro
    func agregar(titulo: String, autor: String) {

        let libro = Libro(
            titulo: titulo,
            autor: autor
        )

        libros.append(libro)

        print("\n✅ Libro registrado correctamente.")
        print("   Título : \(titulo)")
        print("   Autor  : \(autor)")
    }


    // Buscar libro
    private func buscarIndice(titulo: String) -> Int? {

        for i in 0..<libros.count {

            if libros[i].titulo.lowercased() == titulo.lowercased() {
                return i
            }
        }

        return nil
    }


    // Prestar libro
    func prestar(titulo: String) -> Bool {

        guard let indice = buscarIndice(titulo: titulo) else {

            print("\n❌ Libro no encontrado.")
            print("   No existe '\(titulo)' en el inventario.")

            return false
        }

        if libros[indice].estado == .prestado {

            print("\n⚠️ Operación rechazada.")
            print("   '\(libros[indice].titulo)' ya se encuentra prestado.")

            return false
        }

        libros[indice].estado = .prestado

        print("\n✅ Préstamo aprobado.")
        print("   Libro : \(libros[indice].titulo)")
        print("   Autor : \(libros[indice].autor)")

        return true
    }


    // Devolver libro
    func devolver(titulo: String) -> Bool {

        guard let indice = buscarIndice(titulo: titulo) else {

            print("\n❌ Libro no encontrado.")
            print("   No existe '\(titulo)' en el inventario.")

            return false
        }

        if libros[indice].estado == .disponible {

            print("\n⚠️ Operación rechazada.")
            print("   '\(libros[indice].titulo)' ya se encuentra disponible.")

            return false
        }

        libros[indice].estado = .disponible

        print("\n✅ Devolución registrada.")
        print("   Libro : \(libros[indice].titulo)")

        return true
    }


    // Mostrar inventario
    func mostrarInventario() {

        print("\n")
        print("╔════════════════════════════════════════════════════════════╗")
        print("║                 INVENTARIO DE BIBLIOTECA                  ║")
        print("╠════════════════════════════════════════════════════════════╣")

        if libros.isEmpty {

            print("║ No existen libros registrados.                            ║")
            print("╚════════════════════════════════════════════════════════════╝")

            return
        }

        for (indice, libro) in libros.enumerated() {

            print("")
            print("  [\(indice + 1)] \(libro.titulo)")
            print("      Autor  : \(libro.autor)")
            print("      Estado : \(libro.estado.rawValue)")
        }

        print("")
        print("╚════════════════════════════════════════════════════════════╝")

        mostrarResumen()
    }


    // Resumen del inventario
    private func mostrarResumen() {

        var disponibles = 0
        var prestados = 0

        for libro in libros {

            switch libro.estado {

            case .disponible:
                disponibles += 1

            case .prestado:
                prestados += 1
            }
        }

        print("")
        print("RESUMEN")
        print("--------------------------------")
        print("Total       : \(libros.count)")
        print("Disponibles : \(disponibles)")
        print("Prestados   : \(prestados)")
        print("--------------------------------")
    }
}


// MARK: - Interfaz

func mostrarMenu() {

    print("\n")
    print("╔══════════════════════════════════════╗")
    print("║        SISTEMA DE BIBLIOTECA        ║")
    print("╠══════════════════════════════════════╣")
    print("║  1. Ver inventario                  ║")
    print("║  2. Registrar libro                 ║")
    print("║  3. Prestar libro                   ║")
    print("║  4. Devolver libro                  ║")
    print("║  0. Salir                           ║")
    print("╚══════════════════════════════════════╝")
    print("Seleccione una opción: ", terminator: "")
}


// MARK: - Datos iniciales

let biblioteca = Biblioteca()

biblioteca.agregar(
    titulo: "Cien años de soledad",
    autor: "Gabriel García Márquez"
)

biblioteca.agregar(
    titulo: "La ciudad y los perros",
    autor: "Mario Vargas Llosa"
)

biblioteca.agregar(
    titulo: "El Quijote",
    autor: "Miguel de Cervantes"
)


// MARK: - Programa principal

var ejecutando = true

while ejecutando {

    mostrarMenu()

    let opcion = readLine() ?? ""

    switch opcion {

    case "1":

        biblioteca.mostrarInventario()


    case "2":

        print("\nREGISTRAR NUEVO LIBRO")
        print("-----------------------------")

        print("Título: ", terminator: "")
        let titulo = readLine() ?? ""

        print("Autor: ", terminator: "")
        let autor = readLine() ?? ""

        if titulo.isEmpty || autor.isEmpty {

            print("\n❌ El título y el autor son obligatorios.")

        } else {

            biblioteca.agregar(
                titulo: titulo,
                autor: autor
            )
        }


    case "3":

        print("\nPRÉSTAMO DE LIBRO")
        print("-----------------------------")

        print("Ingrese el título: ", terminator: "")

        let titulo = readLine() ?? ""

        _ = biblioteca.prestar(titulo: titulo)


    case "4":

        print("\nDEVOLUCIÓN DE LIBRO")
        print("-----------------------------")

        print("Ingrese el título: ", terminator: "")

        let titulo = readLine() ?? ""

        _ = biblioteca.devolver(titulo: titulo)


    case "0":

        print("\n======================================")
        print("Sistema de biblioteca finalizado.")
        print("======================================")

        ejecutando = false


    default:

        print("\n❌ Opción inválida.")
        print("Seleccione una opción del 0 al 4.")
    }
}
