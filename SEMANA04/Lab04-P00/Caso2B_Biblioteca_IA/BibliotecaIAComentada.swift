enum EstadoLibro {
    case disponible
    case prestado
}

struct Libro {
    let titulo: String
    let autor: String
    var estado: EstadoLibro = .disponible
}

class Biblioteca {
    var libros: [Libro] = []

    func agregar(libro: Libro) {
        libros.append(libro)
    }

    func prestar(titulo: String) -> Bool {
        for i in 0..<libros.count {
            if libros[i].titulo == titulo {
                if libros[i].estado == .disponible {
                    libros[i].estado = .prestado
                    print("Prestamo aprobado: \(titulo)")
                    return true
                }

                print("Error: \(titulo) ya esta prestado")
                return false
            }
        }

        print("Error: no existe \(titulo)")
        return false
    }

    func devolver(titulo: String) -> Bool {
        for i in 0..<libros.count {
            if libros[i].titulo == titulo {
                if libros[i].estado == .prestado {
                    libros[i].estado = .disponible
                    print("Devolucion registrada: \(titulo)")
                    return true
                }

                print("Error: \(titulo) ya esta disponible")
                return false
            }
        }

        print("Error: no existe \(titulo)")
        return false
    }

    func inventario() {
        print("===== INVENTARIO =====")

        for libro in libros {
            var textoEstado = ""

            switch libro.estado {
            case .disponible:
                textoEstado = "disponible"
            case .prestado:
                textoEstado = "prestado"
            }

            print("\(libro.titulo) (\(libro.autor)) - \(textoEstado)")
        }
    }
}

let biblioteca = Biblioteca()

biblioteca.agregar(
    libro: Libro(
        titulo: "Cien anos de soledad",
        autor: "Gabriel Garcia Marquez"
    )
)

biblioteca.agregar(
    libro: Libro(
        titulo: "La ciudad y los perros",
        autor: "Mario Vargas Llosa"
    )
)

biblioteca.agregar(
    libro: Libro(
        titulo: "El Quijote",
        autor: "Miguel de Cervantes"
    )
)

_ = biblioteca.prestar(titulo: "La ciudad y los perros")
_ = biblioteca.prestar(titulo: "La ciudad y los perros")
_ = biblioteca.devolver(titulo: "La ciudad y los perros")
_ = biblioteca.prestar(titulo: "El Quijote")
_ = biblioteca.prestar(titulo: "El Principito")

biblioteca.inventario()
