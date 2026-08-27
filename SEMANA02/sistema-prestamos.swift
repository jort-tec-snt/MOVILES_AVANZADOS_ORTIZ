//Ingreso de datos
import Foundtaion

//Configuracion de dias permitidos por tipo de usuario
let diasPorUsuario: [String: Int] = [
    "alumno": 7,
    "profesor": 15,
    "administrador": 10
]

// Ingresando Datos
print("Titulo libro : ")
let tituloLibro = readLine() ?? ""

print("Tipo de Usuario (Alumno / Docente / Administrativo): ")
let tipoUsuarioInput = (readLine() ?? "").lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

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
guard let fechaLimite = calendario.date(byAdding: .day, value: diasPermitidos, to: fechaPrestado) else { exit(1) }

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
