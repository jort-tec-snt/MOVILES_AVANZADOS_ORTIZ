// Desarrollado por: Jeronimo Ortiz
import Foundation

// ===== Inventario de productos =====
var precios: [String: Double] = [:]
var stocks: [String: Int] = [:]

print("¿Cuántos productos?")
let n = Int(readLine() ?? "") ?? 0

for i in 1...n {
    print("Producto \(i) Nombre:")
    let nombre = readLine() ?? ""
    print("Precio:")
    let precio = Double(readLine() ?? "") ?? 0
    print("Stock:")
    let stock = Int(readLine() ?? "") ?? 0
    
    precios[nombre] = precio
    stocks[nombre] = stock
}

var valorTotalInventario = 0.0
print("\n===== PRODUCTOS CON STOCK BAJO (< 5) =====")
for (nombre, precio) in precios {
    if let stock = stocks[nombre] {
        let valorProducto = precio * Double(stock)
        valorTotalInventario += valorProducto
        
        if stock < 5 {
            print("- \(nombre): Stock actual \(stock) unidades")
        }
    }
}

print("\nValor total del inventario: S/. \(valorTotalInventario)")
