print("\n==================================================")
print("EJERCICIO 3: BUCLES FOR-IN")
print("==================================================")

// --- TODO 7: Tabla de multiplicar del 7 ---
print("Tabla del 7:")
for i in 1...12 {
    print("7 x \(i) = \(7 * i)")
}

// --- TODO 8: Sumatoria del 1 al 100 ---
var suma = 0
for i in 1...100 {
    suma = suma + i
}
print("La suma del 1 al 100 es: \(suma)")

// --- TODO 9: Calcular el factorial de 8 ---
var factorial = 1
for i in 1...8 {
    factorial = factorial * i
}
print("8! = \(factorial)")

// --- TODO 10: Patrón de asteriscos (usando bucles for anidados) ---
print("Patrón de asteriscos:")
for i in 1...5 {
    var fila = ""
    for _ in 1...i {
        fila += "*"
    }
    print(fila)
}

print("\n--- 3.2 Corregir bucles (FIX) ---")
// FIX 4: Imprimir números pares del 2 al 20
print("Pares del 2 al 20:")
for i in 1...20 {
    if i % 2 == 0 { // FIX 4: Se cambió '== 1' por '== 0' porque 0 es el residuo de números pares
        print(i, terminator: " ")
    }
}
print()

// FIX 5: Cuenta regresiva del 10 al 1 usando stride
print("Cuenta regresiva del 10 al 1:")
for i in stride(from: 10, through: 1, by: -1) { // FIX 5: stride permite paso negativo sin errores de rango
    print(i, terminator: " ")
}
print()

print("\n--- 3.3 Respuestas a Predicciones ---")
print("PREDICT 6: Valor = 15, Iteraciones = 5 (suma 1+2+3+4+5).")
print("PREDICT 7: Imprime 'Hola Hola Hola '. El '_' sirve para indicar al compilador que no usamos el valor del contador, evitando variables innecesarias.")

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
let intento1 = 24 // Inválido: > 20
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
