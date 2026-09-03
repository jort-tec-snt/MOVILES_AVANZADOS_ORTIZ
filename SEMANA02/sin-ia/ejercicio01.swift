print("==================================================")
print("EJERCICIO 1: CONDICIONALES IF / ELSE / ELSE IF")
print("==================================================")

// 1.1 — Completar condicionales
// --- Ejemplo (ya resuelto): ---
let nota = 15.0
if nota >= 13.0 {
    print("Aprobado con \(nota)")
} else {
    print("Desaprobado con \(nota)")
}

// --- TODO 1: Validar si una persona es mayor de edad ---
let edad = 17
if edad >= 18 {
    print("Es mayor de edad")
} else {
    print("Es menor de edad")
}

// --- TODO 2: Clasificar una nota con else if ---
let miNota = 16.0
// Categorías: Excelente (18-20), Bueno (15-17), Aprobado (13-14), Desaprobado (0-12)
if miNota >= 18 {
    print("Excelente")
} else if miNota >= 15 {
    print("Bueno")
} else if miNota >= 13 {
    print("Aprobado")
} else {
    print("Desaprobado")
}

// --- TODO 3: Verificar si un número es positivo, negativo o cero ---
let numero = -5
if numero > 0 {
    print("El número \(numero) es positivo")
} else if numero < 0 {
    print("El número \(numero) es negativo")
} else {
    print("El número es cero")
}

print("\n--- 1.2 Corregir errores (FIX) ---")
// Error 1: Falta llave de apertura en else if
// Error 2: Condición de compra estricta (debe ser >= para compras con saldo exacto)
// Error 3: Cálculo invertido (saldo - compra da negativo, debe ser compra - saldo)
let temperatura = 35
if temperatura > 30 {
    print("Hace calor")
} else if temperatura > 20 { // FIX 1: Se agregó la llave "{" que faltaba
    print("Clima agradable")
} else {
    print("Hace frío")
}

let saldo = 100.0
let compra = 150.0
if saldo >= compra { // FIX 2: Debe ser >= para contemplar saldo exacto
    print("Compra realizada")
} else {
    // FIX 3: Se corrigió el orden a (compra - saldo) para que la diferencia faltante sea positiva
    print("Saldo insuficiente: te faltan \(compra - saldo)")
}

let hora = 25
if hora >= 0 && hora < 12 {
    print("Buenos días")
} else if hora >= 12 && hora < 18 {
    print("Buenas tardes")
} else if hora >= 18 && hora <= 23 {
    print("Buenas noches")
} else {
    print("Hora inválida")
}

print("\n--- 1.3 Respuestas a Predicciones ---")
print("PREDICT 1: Imprime 'Dentro del rango' (10 está entre 5 y 20).")
print("PREDICT 2: Imprime 'Mayor que 10'. No imprime 'Mayor que 5' porque el bloque if-else if sale al cumplir la primera condición verdadera.")
print("PREDICT 3: Imprime 'Es lunes O llueve' (esLunes && llueve es false, pero esLunes || llueve es true).")
