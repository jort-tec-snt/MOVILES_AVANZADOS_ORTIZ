print("\n==================================================")
print("EJERCICIO 4: BUCLES WHILE Y REPEAT-WHILE")
print("==================================================")

// --- TODO 11: Ahorro mensual ---
var ahorro = 0.0
var meses = 0
let meta = 2000.0
let ahorroMensual = 150.0
while ahorro < meta {
    ahorro += ahorroMensual
    meses += 1
}
print("Necesita \(meses) meses para juntar S/. \(meta) (Total acumulado: S/. \(ahorro))")

// --- TODO 12: División sucesiva ---
var numeroDivision = 1000.0
var divisiones = 0
while numeroDivision >= 1.0 {
    numeroDivision = numeroDivision / 2.0
    divisiones += 1
    print("División \(divisiones): \(numeroDivision)")
}
print("Se dividió \(divisiones) veces")

// --- TODO 13: Validar datos con repeat-while ---
let intento1 = 25 // Inválido: > 20
let intento2 = -3 // Inválido: < 0
let intento3 = 15 // Válido

var intentoActual = intento1
var esValido = false
var numIntento = 1

repeat {
    if intentoActual >= 0 && intentoActual <= 20 {
        esValido = true
        print("Nota \(intentoActual) válida en intento \(numIntento)")
    } else {
        print("Nota \(intentoActual) inválida, intento \(numIntento)")
        if numIntento == 1 { intentoActual = intento2 }
        if numIntento == 2 { intentoActual = intento3 }
        numIntento += 1
    }
} while !esValido

print("\n--- 4.3 Respuestas a Predicciones ---")
print("PREDICT 8: Valor final = 1, Vueltas = 4 (100->33->11->3->1).")
print("PREDICT 9: Valor = 1. repeat-while ejecuta el bloque al menos una vez porque la condición lógica se evalúa al final (post-evaluación).")
