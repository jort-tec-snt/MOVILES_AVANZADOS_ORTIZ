// Desarrollado por: Jeronimo Ortiz
import Foundation

var registroAlumnos: [String: [Double]] = [:]

print("¿Cuántos alumnos desea registrar?")
let cantidadAlumnos = Int(readLine() ?? "") ?? 0

for i in 1...cantidadAlumnos {
    print("\nNombre del alumno \(i):")
    let nombre = readLine() ?? ""
    var notasAlumno: [Double] = []
    for j in 1...3 {
        print("Ingrese nota \(j) para \(nombre):")
        let nota = Double(readLine() ?? "") ?? 0.0
        notasAlumno.append(nota)
    }
    registroAlumnos[nombre] = notasAlumno
}

print("\n===== REPORTE DE NOTAS =====")
var sumaGeneralPromedios = 0.0
var totalAprobados = 0
var notaMasAlta = -1.0
var notaMasBaja = 21.0
var promediosAlumnos: [(nombre: String, promedio: Double)] = []

for (nombre, notas) in registroAlumnos {
    let sumaNotas = notas.reduce(0, +)
    let promedio = sumaNotas / Double(notas.count)
    sumaGeneralPromedios += promedio
    promediosAlumnos.append((nombre: nombre, promedio: promedio))
    
    for nota in notas {
        if nota > notaMasAlta { notaMasAlta = nota }
        if nota < notaMasBaja { notaMasBaja = nota }
    }
    
    var clasificacion = ""
    switch promedio {
    case 18.0...20.0: clasificacion = "Excelente"
    case 15.0..<18.0: clasificacion = "Bueno"
    case 13.0..<15.0: clasificacion = "Aprobado"
    default: clasificacion = "Desaprobado"
    }
    
    if promedio >= 13.0 { totalAprobados += 1 }
    print("\(nombre) - Promedio: \(promedio) | Clasificación: \(clasificacion)")
}

print("\n===== ESTADÍSTICAS GENERALES =====")
if cantidadAlumnos > 0 {
    let promedioGeneral = sumaGeneralPromedios / Double(cantidadAlumnos)
    let porcentajeAprobados = (Double(totalAprobados) / Double(cantidadAlumnos)) * 100.0
    print("Promedio General: \(promedioGeneral)")
    print("Nota más alta registrada: \(notaMasAlta)")
    print("Nota más baja registrada: \(notaMasBaja)")
    print("Porcentaje de aprobados: \(porcentajeAprobados)%")
}

print("\n===== RANKING (ORDENADO POR PROMEDIO) =====")
let ranking = promediosAlumnos.sorted { $0.promedio > $1.promedio }
for (posicion, alumno) in ranking.enumerated() {
    print("\(posicion + 1). \(alumno.nombre): \(alumno.promedio)")
}
