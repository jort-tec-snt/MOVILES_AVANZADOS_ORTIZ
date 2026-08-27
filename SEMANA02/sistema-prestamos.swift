import Foundation

// Estructura para almacenar cada prestamo en el historial
struct Prestamo {
    let libro: String
    let usuario: String
    let dias: Int
    let multa: Double
    let estado: String
    let situacion: String
}

// Configuracion de dias permitidos por tipo de usuario
let diasPorUsuario: [String: Int] = [
    "alumno": 7,
    "docente": 15,
    "administrativo": 10
]

var historialPrestamos: [Prestamo] = []

let formatter = DateFormatter()
formatter.dateFormat = "dd/MM/yyyy"
formatter.isLenient = false

let calendario = Calendar.current

// Capturar el año actual de la Mac de forma dinámica (Ej: 2026)
let anioActual = calendario.component(.year, from: Date())

var continuarSistema = true

while continuarSistema {
    print("\n========================================")
    print("   SISTEMA DE GESTIÓN DE BIBLIOTECA   ")
    print("========================================")
    print("1. Registrar nuevo préstamo")
    print("2. Ver lista de libros prestados (Historial)")
    print("3. Salir del sistema")
    print("Seleccione una opción: ")
    
    let opcionMenu = readLine() ?? ""
    
    switch opcionMenu {
    case "1":
        print("\n--- REGISTRO DE PRÉSTAMO ---")
        print("Titulo libro : ")
        let tituloLibro = readLine() ?? ""

        var tipoUsuarioInput = ""
        var limiteMaximo = 0
        var diasSolicitados = 0

        // Bucle interactivo: Validar Tipo de Usuario
        while true {
            print("Tipo de Usuario (Alumno / Docente / Administrativo): ")
            tipoUsuarioInput = (readLine() ?? "").lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            limiteMaximo = diasPorUsuario[tipoUsuarioInput] ?? 0
                
            if limiteMaximo > 0 { break }
            print("❌ Error: Tipo de usuario inválido. Intente nuevamente.\n")
        }

        // Bucle interactivo: Validar Días Solicitados
        while true {
            print("Días solicitados de préstamo (Máximo \(limiteMaximo) días): ")
            diasSolicitados = Int(readLine() ?? "") ?? 0
            
            if diasSolicitados > 0 && diasSolicitados <= limiteMaximo { break }
            print("❌ Error: Cantidad de días inválida o supera el límite permitido de \(limiteMaximo) días. Intente nuevamente.\n")
        }

        var fechaPrestado: Date? = nil
        // Bucle interactivo: Validar Fecha de Préstamo Estricta (Filtro Año Actual)
        while true {
            print("Fecha prestado (DD/MM/YYYY): ")
            let input = readLine() ?? ""
            if input.count == 10, let date = formatter.date(from: input) {
                let anioInput = calendario.component(.year, from: date)
                
                // FILTRO CLAVE: Validar que corresponda al año actual
                if anioInput == anioActual {
                    fechaPrestado = date
                    break
                } else {
                    print("❌ Error: Solo se permiten registros del año en curso (\(anioActual)).\n")
                    continue
                }
            }
            print("❌ Error: Formato incorrecto. Use estrictamente DD/MM/YYYY (Ej. 27/08/\(anioActual)).\n")
        }

        var fechaDevolucion: Date? = nil
        // Bucle interactivo: Validar Fecha de Devolución Coherente
        while true {
            print("Fecha devolución (DD/MM/YYYY): ")
            let input = readLine() ?? ""
            
            if input.count == 10, let date = formatter.date(from: input) {
                let anioInput = calendario.component(.year, from: date)
                
                if anioInput != anioActual {
                    print("❌ Error: La fecha de devolución debe pertenecer al año en curso (\(anioActual)).\n")
                    continue
                }
                
                if date >= fechaPrestado! {
                    fechaDevolucion = date
                    break
                } else {
                    print("❌ Error Lógico: La fecha de devolución no puede ser anterior a la de préstamo.\n")
                    continue
                }
            }
            print("❌ Error: Formato incorrecto. Use estrictamente DD/MM/YYYY.\n")
        }

        guard let fPrestado = fechaPrestado, let fDevolucion = fechaDevolucion else { continue }
        guard let fechaLimite = calendario.date(byAdding: .day, value: diasSolicitados, to: fPrestado) else { continue }

        let componentes = calendario.dateComponents([.day], from: fechaLimite, to: fDevolucion)
        let diasAtraso = max(0, componentes.day ?? 0)

        // Mostrar el desglose intermedio solicitado
        print("\nLibro : \(tituloLibro)")
        print("Usuario : \(tipoUsuarioInput.capitalized)")
        print("Fecha prestada : \(formatter.string(from: fPrestado))")
        print("Fecha limite : \(formatter.string(from: fechaLimite))")
        print("Fecha devolución : \(formatter.string(from: fDevolucion))")
        print("Dias de atraso : \(diasAtraso)")

        var multaTotal: Double = 0.0

        if diasAtraso > 0 {
            print("\nDia  | Fecha    | Multa x dia | Acumulado en soles")
            print("--------------------------------------------------")
            
            for dia in 1...diasAtraso {
                guard let fechaDiaAtraso = calendario.date(byAdding: .day, value: dia, to: fechaLimite) else { break }
                let fechaDiaStr = formatter.string(from: fechaDiaAtraso)
                
                let multaBase = 1.50
                var multaDia = multaBase
                
                if dia >= 4 && dia <= 6 {
                    multaDia = multaBase * 1.50
                } else if dia >= 7 {
                    multaDia = multaBase * 2.00
                }
                
                multaTotal += multaDia
                
                // OPTIMIZACIÓN IMPRESIÓN: Imprime detallado solo hasta el día 10 para no saturar la terminal
                if dia <= 10 {
                    print(String(format: "%-4d | %-8@ | %-11.2f | %.2f", dia, fechaDiaStr, multaDia, multaTotal))
                } else if dia == 11 {
                    print("... [Calendario truncado por exceso de filas] ...")
                }
            }
        }

        let estadoPrestamo = diasAtraso > 0 ? "Devuelto con atraso" : "Devuelto a tiempo"
        let situacionUsuario = diasAtraso >= 10 ? "Usuario suspendido" : "Usuario habilitado"

        print("\nMulta total: \(String(format: "%.2f", multaTotal))")
        print("Estado:  \(estadoPrestamo)")
        print("Situación: \(situacionUsuario)")

        // Guardar en el historial
        let nuevoPrestamo = Prestamo(libro: tituloLibro, usuario: tipoUsuarioInput.capitalized, dias: diasSolicitados, multa: multaTotal, estado: estadoPrestamo, situacion: situacionUsuario)
        historialPrestamos.append(nuevoPrestamo)
        print("\n✅ Préstamo registrado y almacenado correctamente en el sistema.")

    case "2":
        print("\n=======================================================")
        print("         HISTORIAL DE LIBROS ALMACENADOS               ")
        print("=======================================================")
        if historialPrestamos.isEmpty {
            print("No hay libros registrados en el sistema por el momento.")
        } else {
            for (index, prestamo) in historialPrestamos.enumerated() {
                print("\(index + 1). Libro: \(prestamo.libro) | Usuario: \(prestamo.usuario) | Días Solicitados: \(prestamo.dias) | Multa: S/.\(String(format: "%.2f", prestamo.multa)) | \(prestamo.situacion)")
            }
        }
        print("=======================================================")
        
    case "3":
        print("Saliendo del sistema de biblioteca. ¡Hasta luego, broder!")
        continuarSistema = false
        
    default:
        print("❌ Opción inválida. Seleccione 1, 2 o 3.")
    }
}
