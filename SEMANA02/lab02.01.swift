import Foundation

//Definir promedio de pesos
let parcial = 0.3
let trabajo = 0.3
let final = 0.4

//Commit del ingreso de datosprint
print ("Nombre del Alumno: ")
let alumno = readLine() ?? ""

print ("Nota del Examen Parcial : ")
let exParcial = Double(readLine() ?? "") ?? 0.0

print("Nota del Trabajo Completo: ")
let exTrabajo = Double(readLine() ?? "") ?? 0.0

print("Nota del Examen Final: ")
let exFinal = Double(readLine() ?? "") ?? 0.0

// [BLOQUE 2: CALCULO]
let notaFinal = (exParcial * parcial) + (exTrabajo * trabajo) + (exFinal * final)
let estado = notaFinal >= 10.5 ? "Aprobado" : "Desaprobado"


//[BLOQUE 3: Mostrando datos]
print("\n--- REPORTE DE NOTAS ---")
print("Alumno: \(alumno)")
print("Promedio Final: \(String(format: "%.2f", notaFinal))")
print("Estado: \(estado)")
