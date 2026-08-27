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
