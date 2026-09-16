struct Curso {
    let nombre: String
    let precio: Double
}

class Estudiante {
    let nombre: String
    let dni: String
    let esAlumnoTecsup: Bool

    init(nombre: String, dni: String, esAlumnoTecsup: Bool) {
        self.nombre = nombre
        self.dni = dni
        self.esAlumnoTecsup = esAlumnoTecsup
    }
}

class FacturaCursos {
    let estudiante: Estudiante
    var cursos: [Curso] = []
    let tasaIgv: Double = 0.18

    init(estudiante: Estudiante) {
        self.estudiante = estudiante
    }

    func agregarCurso(curso: Curso) {
        cursos.append(curso)
    }

    func calcularSubtotal() -> Double {
        var subtotal = 0.0

        for curso in cursos {
            subtotal += curso.precio
        }

        return subtotal
    }

    func calcularIgv() -> Double {
        return calcularSubtotal() * tasaIgv
    }

    func calcularTotalConIgv() -> Double {
        return calcularSubtotal() + calcularIgv()
    }

    func calcularDescuentoCantidad() -> Double {
        if cursos.count >= 3 {
            return calcularTotalConIgv() * 0.10
        }

        return 0.0
    }

    func calcularDescuentoTecsup() -> Double {
        if cursos.count >= 3 && estudiante.esAlumnoTecsup {
            return 400.0
        }

        return 0.0
    }

    func calcularTotalFinal() -> Double {
        return calcularTotalConIgv() - calcularDescuentoCantidad() - calcularDescuentoTecsup()
    }

    func mostrarFactura() {
        print("===== FACTURA DE CURSOS =====")
        print("Estudiante: \(estudiante.nombre)")
        print("DNI: \(estudiante.dni)")
        print("Alumno Tecsup: \(estudiante.esAlumnoTecsup ? "Si" : "No")")
        print("===== CURSOS =====")

        for curso in cursos {
            print("\(curso.nombre) - S/ \(curso.precio)")
        }

        print("Subtotal: S/ \(calcularSubtotal())")
        print("IGV 18%: S/ \(calcularIgv())")
        print("Total con IGV: S/ \(calcularTotalConIgv())")
        print("Descuento 10%: S/ \(calcularDescuentoCantidad())")
        print("Descuento Tecsup: S/ \(calcularDescuentoTecsup())")
        print("Total final: S/ \(calcularTotalFinal())")
    }
}

let estudiante = Estudiante(
    nombre: "Ana Torres",
    dni: "76543210",
    esAlumnoTecsup: true
)

let factura = FacturaCursos(estudiante: estudiante)
factura.agregarCurso(curso: Curso(nombre: "SWIFT AVANZADO", precio: 700.0))
factura.agregarCurso(curso: Curso(nombre: "IA con Python", precio: 850.0))
factura.agregarCurso(curso: Curso(nombre: "Diseno UX/UI", precio: 650.0))
factura.mostrarFactura()
