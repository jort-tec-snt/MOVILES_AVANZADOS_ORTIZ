enum EstadoLibro { // Define un tipo propio para limitar el estado del libro a valores validos del dominio.
    case disponible // Representa que el libro puede prestarse porque aun no esta en manos de otro lector.
    case prestado // Representa que el libro ya fue prestado y no debe aprobarse otro prestamo del mismo ejemplar.
}

struct Libro { // Modela cada libro como dato de valor, adecuado para guardar titulo, autor y estado.
    let titulo: String // Guarda el nombre del libro y se mantiene constante para no cambiar la identidad del registro.
    let autor: String // Guarda el autor del libro y tambien se mantiene constante durante la simulacion.
    var estado: EstadoLibro = .disponible // Permite cambiar solo el estado; inicia disponible para cumplir la regla de libro nuevo.
}

class Biblioteca { // Usa una clase para que la biblioteca mantenga un estado compartido mientras se agregan y modifican libros.
    var libros: [Libro] = [] // Crea el inventario inicialmente vacio, donde cada elemento es un struct Libro.

    func agregar(libro: Libro) { // Recibe un libro ya construido para incorporarlo al inventario.
        libros.append(libro) // Agrega el libro al final del array y conserva el orden de registro para mostrarlo luego.
    }

    func prestar(titulo: String) -> Bool { // Busca un titulo y devuelve true solo si el prestamo realmente se aprueba.
        for i in 0..<libros.count { // Recorre los indices para poder modificar el struct directamente dentro del array.
            if libros[i].titulo == titulo { // Compara el titulo pedido con el titulo del libro ubicado en la posicion actual.
                if libros[i].estado == .disponible { // Verifica que el libro encontrado este libre antes de aprobar el prestamo.
                    libros[i].estado = .prestado // Modifica el struct dentro del array; cambiar una copia no actualizaria el inventario.
                    print("Prestamo aprobado: \(titulo)") // Informa que el cambio de estado se realizo correctamente.
                    return true // Termina la funcion indicando que la operacion fue exitosa.
                }

                print("Error: \(titulo) ya esta prestado") // Informa que el titulo existe pero no puede prestarse de nuevo.
                return false // Termina la funcion porque ya se encontro el libro y la operacion fallo.
            }
        }

        print("Error: no existe \(titulo)") // Se ejecuta solo si el recorrido completo no encontro coincidencias por titulo.
        return false // Indica que no hubo prestamo porque el libro no pertenece al inventario.
    }

    func devolver(titulo: String) -> Bool { // Busca un titulo y devuelve true solo si la devolucion cambia el estado del libro.
        for i in 0..<libros.count { // Recorre por indice para actualizar directamente el elemento almacenado en el array.
            if libros[i].titulo == titulo { // Identifica si el libro de la posicion actual es el que se quiere devolver.
                if libros[i].estado == .prestado { // Solo permite devolver libros que realmente figuran como prestados.
                    libros[i].estado = .disponible // Actualiza el libro dentro del array para dejarlo nuevamente disponible.
                    print("Devolucion registrada: \(titulo)") // Informa que la biblioteca acepto la devolucion.
                    return true // Confirma que la operacion hizo un cambio valido en el inventario.
                }

                print("Error: \(titulo) ya esta disponible") // Evita registrar una devolucion sobre un libro que no estaba prestado.
                return false // Indica que la devolucion no procedio porque el estado no correspondia.
            }
        }

        print("Error: no existe \(titulo)") // Informa que no se puede devolver un titulo que no esta registrado.
        return false // Indica fallo porque el libro no fue encontrado.
    }

    func inventario() { // Muestra todos los libros con sus autores y el estado textual solicitado.
        print("===== INVENTARIO =====") // Imprime el encabezado para separar el reporte de las operaciones anteriores.

        for libro in libros { // Recorre los libros por valor porque aqui solo se necesita leer y mostrar informacion.
            var textoEstado = "" // Prepara una variable String para convertir el enum en texto visible en consola.

            switch libro.estado { // Usa switch, como pide el laboratorio, para decidir el texto segun el estado.
            case .disponible: // Rama usada cuando el libro se encuentra disponible.
                textoEstado = "disponible" // Asigna el texto que se imprimira para el estado disponible.
            case .prestado: // Rama usada cuando el libro esta prestado.
                textoEstado = "prestado" // Asigna el texto que se imprimira para el estado prestado.
            }

            print("\(libro.titulo) (\(libro.autor)) - \(textoEstado)") // Imprime una linea del inventario con titulo, autor y estado.
        }
    }
}

let biblioteca = Biblioteca() // Crea una unica biblioteca para conservar el inventario durante toda la simulacion.

biblioteca.agregar(libro: Libro(titulo: "Cien anos de soledad", autor: "Gabriel Garcia Marquez")) // Registra el primer libro disponible.
biblioteca.agregar(libro: Libro(titulo: "La ciudad y los perros", autor: "Mario Vargas Llosa")) // Registra el segundo libro disponible.
biblioteca.agregar(libro: Libro(titulo: "El Quijote", autor: "Miguel de Cervantes")) // Registra el tercer libro disponible.

_ = biblioteca.prestar(titulo: "La ciudad y los perros") // Descarta explicitamente el Bool porque la evidencia principal es el mensaje impreso.
_ = biblioteca.prestar(titulo: "La ciudad y los perros") // Descarta el Bool del intento repetido, que debe fallar porque ya esta prestado.
_ = biblioteca.devolver(titulo: "La ciudad y los perros") // Descarta el Bool porque la devolucion correcta se confirma con el mensaje.
_ = biblioteca.prestar(titulo: "El Quijote") // Descarta el Bool del prestamo valido para continuar con la simulacion.
_ = biblioteca.prestar(titulo: "El Principito") // Descarta el Bool del caso fallido porque el titulo no fue agregado.
biblioteca.inventario() // Muestra el estado final de los tres libros registrados.
