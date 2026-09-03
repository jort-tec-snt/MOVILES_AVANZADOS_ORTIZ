print("\n==================================================")
print("EJERCICIO 2: SWITCH")
print("==================================================")

// --- TODO 4: Clasificar nota numérica a letra ---
let notaEstudiante = 16
switch notaEstudiante {
case 18...20:
    print("Nota: A (Excelente)")
case 15...17:
    print("Nota: B (Bueno)")
case 13...14:
    print("Nota: C (Aprobado)")
case 11...12:
    print("Nota: D (Regular)")
case 0...10:
    print("Nota: F (Desaprobado)")
default:
    print("Nota inválida")
}

// --- TODO 5: Calculadora simple con switch ---
let num1 = 18.0
let num2 = 5.0
let operacion = "+"
switch operacion {
case "+":
    print("Resultado: \(num1 + num2)")
case "-":
    print("Resultado: \(num1 - num2)")
case "*":
    print("Resultado: \(num1 * num2)")
case "/":
    if num2 != 0 {
        print("Resultado: \(num1 / num2)")
    } else {
        print("Error: No se puede dividir entre cero")
    }
default:
    print("Operación no válida")
}

// --- TODO 6: Categoría de producto por precio ---
let precio = 350.0
// Categorías: Económico (0-99), Medio (100-499), Premium (500-999), Lujo (1000+)
switch precio {
case 0..<100:
    print("Categoría: Económico")
case 100..<500:
    print("Categoría: Medio")
case 500..<1000:
    print("Categoría: Premium")
case 1000...:
    print("Categoría: Lujo")
default:
    print("Precio inválido")
}

print("\n--- 2.2 Respuestas a Predicciones ---")
print("PREDICT 4: Imprime '28 o 29 días' (coincide con case 2).")
print("PREDICT 5: Imprime 'Vocal' (coincide con 'a' en la lista de casos).")
