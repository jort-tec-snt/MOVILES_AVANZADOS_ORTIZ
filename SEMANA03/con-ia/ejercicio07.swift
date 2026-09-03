// Desarrollado por: Jeronimo Ortiz
import Foundation

var nombresProductos: [String] = []
var preciosProductos: [Double] = []
var stocksProductos: [Int] = []

print("¿Cuántos productos registrará inicialmente?")
let iniciales = Int(readLine() ?? "") ?? 0

for i in 1...iniciales {
    print("\nProducto \(i) - Nombre:")
    nombresProductos.append(readLine() ?? "")
    print("Precio:")
    preciosProductos.append(Double(readLine() ?? "") ?? 0.0)
    print("Stock:")
    stocksProductos.append(Int(readLine() ?? "") ?? 0)
}

var continuar = true

while continuar {
    print("\n===== MENÚ DE INVENTARIO =====")
    print("1) Ver inventario")
    print("2) Buscar producto")
    print("3) Ver productos con stock bajo (< 5)")
    print("4) Ver valor total del inventario")
    print("5) Salir")
    print("Seleccione una opción (1-5):")
    
    let opcion = readLine() ?? ""
    
    switch opcion {
    case "1":
        print("\n--- INVENTARIO GENERAL ---")
        for i in 0..<nombresProductos.count {
            print("[\(i+1)] \(nombresProductos[i]) | Precio: S/. \(preciosProductos[i]) | Stock: \(stocksProductos[i])")
        }
    case "2":
        print("\nIngrese el nombre del producto a buscar:")
        let busqueda = readLine() ?? ""
        if let indice = nombresProductos.firstIndex(of: busqueda) {
            print("¡Encontrado! \(nombresProductos[indice]) -> Precio: S/. \(preciosProductos[indice]) | Stock: \(stocksProductos[indice])")
        } else {
            print("El producto '\(busqueda)' no se encuentra en el inventario.")
        }
    case "3":
        print("\n--- PRODUCTOS CON STOCK BAJO (< 5) ---")
        var contadorBajos = 0
        for i in 0..<nombresProductos.count {
            if stocksProductos[i] < 5 {
                print("ALERTA: \(nombresProductos[i]) tiene solo \(stocksProductos[i]) unidades en stock.")
                contadorBajos += 1
            }
        }
        if contadorBajos == 0 { print("Todos los productos tienen stock adecuado.") }
    case "4":
        var valorTotal = 0.0
        for i in 0..<nombresProductos.count {
            valorTotal += preciosProductos[i] * Double(stocksProductos[i])
        }
        print("\nValor financiero total del inventario: S/. \(valorTotal)")
    case "5":
        print("Saliendo del sistema de inventario...")
        continuar = false
    default:
        print("Opción inválida. Intente de nuevo con un número entre 1 y 5.")
    }
}
