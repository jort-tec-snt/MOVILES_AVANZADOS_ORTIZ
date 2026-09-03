// Desarrollado por: Jeronimo Ortiz
import Foundation

// ===== Eliminar duplicados =====
var numeros: [Int] = []
for i in 1...8 {
    print("Número \(i):")
    let n = Int(readLine() ?? "") ?? 0
    numeros.append(n)
}
print("Con duplicados: \(numeros)")
let sinDuplicados = Array(Set(numeros)).sorted()
print("Sin duplicados: \(sinDuplicados)")

// ===== Comparar asistencia =====
var asistenciaLunes: Set<String> = []
print("===== ASISTENCIA LUNES =====")
for i in 1...4 {
    print("Nombre \(i):")
    asistenciaLunes.insert(readLine() ?? "")
}

var asistenciaMartes: Set<String> = []
print("===== ASISTENCIA MARTES =====")
for i in 1...4 {
    print("Nombre \(i):")
    asistenciaMartes.insert(readLine() ?? "")
}

print("\n===== RESULTADOS ASISTENCIA =====")
print("Asistieron ambos días: \(asistenciaLunes.intersection(asistenciaMartes))")
print("Solo asistieron lunes: \(asistenciaLunes.subtracting(asistenciaMartes))")
print("Solo asistieron martes: \(asistenciaMartes.subtracting(asistenciaLunes))")
