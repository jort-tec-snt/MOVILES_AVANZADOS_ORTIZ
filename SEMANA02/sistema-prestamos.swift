//Ingreso de datos
import Foundation

//Configuracion de dias permitidos por tipo de usuario
let diasPorUsuario: [String: Int] = [
    "alumno": 7,
    "docente": 15,
    "administrativo": 10
]

// Ingresando Datos
print("Titulo libro : ")
let tituloLibro = readLine() ?? ""

// Variables vacías que se llenarán dentro de los bucles
var tipoUsuarioInput = ""
var limiteMaximo = 0
var diasSolicitados = 0

while true {
    print("Tipo de Usuario (Alumno / Docente / Administrativo): ")
    tipoUsuarioInput = (readLine() ?? "").lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    
    limiteMaximo = diasPorUsuario[tipoUsuarioInput] ?? 0
        
        if limiteMaximo > 0 {
            break // Entrada válida, salimos del bucle
        } else {
            print("❌ Error: Tipo de usuario inválido. Intente nuevamente.\n")
        }
}

while true {
    print("Días solicitados de préstamo (Máximo \(limiteMaximo) días): ")
    diasSolicitados = Int(readLine() ?? "") ?? 0
    
    if diasSolicitados > 0 && diasSolicitados <= limiteMaximo {
        break // Entrada válida, salimos del bucle
    } else {
        print("❌ Error: Cantidad de días inválida o supera el límite permitido de \(limiteMaximo) días. Intente nuevamente.\n")
    }
}

print("Fecha prestado (DD/MM/AA): ")
let fechaPrestadoStr = readLine() ?? ""

print("Fecha devolución (DD/MM/AA): ")
let fechaDevolucionStr = readLine() ?? ""

// Procesamiento y detalles
let formatter = DateFormatter()
formatter.dateFormat = "dd/MM/yy"

// Validar que las fechas ingresadas sean correctas
guard let fechaPrestado = formatter.date(from: fechaPrestadoStr),
      let fechaDevolucion = formatter.date(from: fechaDevolucionStr) else {
    print("Error: Formato de fecha incorrecto. Use DD/MM/AA")
    exit(1)
}

// Obtener los días de préstamo permitidos
let diasPermitidos = diasPorUsuario[tipoUsuarioInput] ?? 0
if diasPermitidos == 0 {
    print("Error: Tipo de usuario inválido.")
    exit(1)
}

// Calcular la fecha límite sumando los días permitidos
let calendario = Calendar.current
guard let fechaLimite = calendario.date(byAdding: .day, value: diasSolicitados, to: fechaPrestado) else { exit(1) }

// Calcular días de atraso reales
let componentes = calendario.dateComponents([.day], from: fechaLimite, to: fechaDevolucion)
let diasAtraso = max(0, componentes.day ?? 0)

// Mostrar el desglose intermedio solicitado
print("\nLibro : \(tituloLibro)")
print("Usuario : \(tipoUsuarioInput.capitalized)")
print("Fecha prestada : \(formatter.string(from: fechaPrestado))")
print("Fecha limite : \(formatter.string(from: fechaLimite))")
print("Fecha devolución : \(formatter.string(from: fechaDevolucion))")
print("Dias de atraso : \(diasAtraso)")

// Calendario de opciones y resultado final
var multaTotal: Double = 0.0

if diasAtraso > 0 {
    print("\nDia  | Fecha    | Multa x dia | Acumulado en soles")
    print("--------------------------------------------------")
    
    for dia in 1...diasAtraso {
        // Calcular la fecha exacta de cada día de retraso
        guard let fechaDiaAtraso = calendario.date(byAdding: .day, value: dia, to: fechaLimite) else { break }
        let fechaDiaStr = formatter.string(from: fechaDiaAtraso)
        
        let multaBase = 1.50
        var multaDia = multaBase
        
        // Aplicar reglas de multa progresiva
        if dia >= 4 && dia <= 6 {
            multaDia = multaBase * 1.50 // 50% adicional -> 2.25
        } else if dia >= 7 {
            multaDia = multaBase * 2.00 // 100% adicional -> 3.00
        }
        
        multaTotal += multaDia
        
        // Imprimir fila con formato alineado
        print(String(format: "%-4d | %-8@ | %-11.2f | %.2f", dia, fechaDiaStr, multaDia, multaTotal))
    }
}

// Determinar las situaciones reglamentarias del sistema
let estadoPrestamo = diasAtraso > 0 ? "Devuelto con atraso" : "Devuelto a tiempo"
let situacionUsuario = diasAtraso >= 10 ? "Usuario suspendido" : "Usuario habilitado"

print("\nMulta total: \(String(format: "%.2f", multaTotal))")
print("Estado:  \(estadoPrestamo)")
print("Situation: \(situacionUsuario)")
