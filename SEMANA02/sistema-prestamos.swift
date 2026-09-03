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

// Estructura auxiliar para la configuración por tipo de usuario
struct ConfigUsuario {
    let maxDias: Int
    let costoBase: Double
}

// Configuración de días permitidos y costo base diario por tipo de usuario
let configUsuarios: [String: ConfigUsuario] = [
    "alumno": ConfigUsuario(maxDias: 7, costoBase: 1.50),
    "docente": ConfigUsuario(maxDias: 15, costoBase: 2.00),
    "administrativo": ConfigUsuario(maxDias: 10, costoBase: 3.00),
    "coordinador": ConfigUsuario(maxDias: 15, costoBase: 4.00)
]

var historialPrestamos: [Prestamo] = []

let formatter = DateFormatter()
formatter.dateFormat = "dd/MM/yyyy"
formatter.isLenient = false

let calendario = Calendar.current

// Capturar el año actual de la Mac de forma dinámica
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
        var costoBaseUsuario = 0.0
        var diasSolicitados = 0

        // Bucle interactivo: Validar Tipo de Usuario (Alumno / Docente / Administrativo / Coordinador)
        while true {
            print("Tipo de Usuario (Alumno / Docente / Administrativo / Coordinador): ")
            tipoUsuarioInput = (readLine() ?? "").lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            
            if let config = configUsuarios[tipoUsuarioInput] {
                limiteMaximo = config.maxDias
                costoBaseUsuario = config.costoBase
                break
            }
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
        print("Costo Base/Día : S/. \(String(format: "%.2f", costoBaseUsuario))")
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
                
                var multaDia = 0.0
                
                // LÓGICA DE MULTA PROGRESIVA
                if dia >= 1 && dia <= 3 {
                    multaDia = 0.0 // Del 1 al 3 de atraso: no paga
                } else if dia >= 4 && dia <= 6 {
                    multaDia = costoBaseUsuario * 1.25 // Del 4 al 6: 25% adicional
                } else if dia >= 7 && dia <= 10 {
                    multaDia = costoBaseUsuario * 1.50 // Del 7 al 10: 50% adicional
                } else if dia >= 11 {
                    multaDia = costoBaseUsuario * 2.00 // De 11 en adelante: 100% adicional
                }
                
                multaTotal += multaDia
                
                // OPTIMIZACIÓN IMPRESIÓN: Imprime detallado solo hasta el día 20 para no saturar la consola
                if dia <= 20 {
                    print(String(format: "%-4d | %-8@ | %-11.2f | %.2f", dia, fechaDiaStr, multaDia, multaTotal))
                } else if dia == 21 {
                    print("... [Calendario truncado por exceso de filas] ...")
                }
            }
        }

        let estadoPrestamo = diasAtraso > 0 ? "Devuelto con atraso" : "Devuelto a tiempo"
        // Si los días de atraso son más de 20 días, el usuario queda suspendido
        let situacionUsuario = diasAtraso > 20 ? "Usuario suspendido" : "Usuario habilitado"

        print("\nMulta total: S/. \(String(format: "%.2f", multaTotal))")
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
