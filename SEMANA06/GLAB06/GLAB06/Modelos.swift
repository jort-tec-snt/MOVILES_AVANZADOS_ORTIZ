// Desarrollado por: Jeronimo Ortiz
import UIKit

class Producto {
    let nombre: String
    let precio: Double
    var stock: Int

    init(nombre: String, precio: Double, stock: Int) {
        self.nombre = nombre
        self.precio = precio
        self.stock = stock
    }
}

class ItemCarrito {
    let producto: Producto
    var cantidad: Int

    init(producto: Producto, cantidad: Int) {
        self.producto = producto
        self.cantidad = cantidad
    }

    // Cada línea sabe calcular su propio subtotal
    func subtotal() -> Double {
        return producto.precio * Double(cantidad)
    }
}

class CarritoModel {
    var items: [ItemCarrito] = []

    // A1: no supera el stock (contando lo ya añadido) y no repite líneas
    func agregar(producto: Producto, cantidad: Int) -> Bool {
        guard cantidad > 0 else { return false }
        let linea = items.first { $0.producto === producto }
        let yaEnCarrito = linea?.cantidad ?? 0
        if yaEnCarrito + cantidad > producto.stock {
            return false
        }
        if let linea = linea {
            linea.cantidad += cantidad
        } else {
            items.append(ItemCarrito(producto: producto, cantidad: cantidad))
        }
        return true
    }

    // A2
    func subtotal() -> Double {
        return items.reduce(0) { $0 + $1.subtotal() }
    }

    // A3: tramos sobre el subtotal (Regla 6)
    func porcentajeDescuento() -> Double {
        let base = subtotal()
        if base >= 5000 {
            return 0.15
        } else if base >= 2000 {
            return 0.10
        } else if base >= 500 {
            return 0.05
        } else {
            return 0.0
        }
    }

    // A4
    func cantidadTotal() -> Int {
        return items.reduce(0) { $0 + $1.cantidad }
    }

    // A5
    func vaciar() {
        items.removeAll()
    }

    // Cálculos derivados: viven en el modelo (Regla 5)
    func montoDescuento() -> Double {
        return subtotal() * porcentajeDescuento()
    }

    // El IGV (18 %) se calcula sobre el monto ya descontado (Regla 6)
    func igv() -> Double {
        return (subtotal() - montoDescuento()) * 0.18
    }

    func total() -> Double {
        return subtotal() - montoDescuento() + igv()
    }

    // Categoría del cliente según el subtotal (Regla 7)
    func categoria() -> String {
        switch Int(subtotal()) {
        case ..<500:
            return "Regular"
        case 500..<2000:
            return "Frecuente"
        case 2000..<5000:
            return "VIP"
        default:
            return "Premium"
        }
    }

    // Regla 9: el stock baja según lo comprado y el carrito se vacía
    func confirmarCompra() {
        for item in items {
            item.producto.stock -= item.cantidad
        }
        vaciar()
    }
}

// MARK: - Utilidades compartidas por las pantallas

func soles(_ valor: Double) -> String {
    return String(format: "S/ %.2f", valor)
}

extension UIViewController {
    func mostrarAlerta(_ titulo: String, _ mensaje: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alerta, animated: true)
    }

    // Mismo estilo oscuro/cobre que las pantallas de clientes y nueva venta
    func aplicarTemaTienda() {
        overrideUserInterfaceStyle = .dark
        let cobre = UIColor(red: 0.925, green: 0.733, blue: 0.486, alpha: 1)
        let texto = UIColor(red: 0.961, green: 0.945, blue: 0.910, alpha: 1)
        let barra = UINavigationBarAppearance()
        barra.configureWithOpaqueBackground()
        barra.backgroundColor = UIColor(red: 0.082, green: 0.106, blue: 0.122, alpha: 1)
        barra.titleTextAttributes = [.foregroundColor: texto]
        barra.largeTitleTextAttributes = [.foregroundColor: texto]
        barra.shadowColor = cobre.withAlphaComponent(0.3)
        navigationItem.standardAppearance = barra
        navigationItem.scrollEdgeAppearance = barra
        navigationItem.compactAppearance = barra
        navigationController?.navigationBar.tintColor = cobre
    }
}
