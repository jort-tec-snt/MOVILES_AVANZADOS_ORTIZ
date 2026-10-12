// Desarrollado por: Jeronimo Ortiz
import UIKit

class BoletaViewController: UIViewController {
    // Llegan desde Datos del cliente por prepare(for:sender:)
    var carrito: CarritoModel!
    var cliente: ClienteModel!

    @IBOutlet weak var lblBoleta: UILabel!

    private let ancho = 40

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        lblBoleta.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        // Primero se arma la boleta con el carrito intacto; luego se confirma la compra (Regla 9)
        lblBoleta.text = construirBoleta()
        carrito.confirmarCompra()
    }

    private func fila(_ izquierda: String, _ derecha: String) -> String {
        let espacios = max(1, ancho - izquierda.count - derecha.count)
        return izquierda + String(repeating: " ", count: espacios) + derecha
    }

    private func construirBoleta() -> String {
        let raya = String(repeating: "-", count: ancho)
        let doble = String(repeating: "=", count: ancho)
        let porcentaje = Int((carrito.porcentajeDescuento() * 100).rounded())

        var lineas = [
            "=========== BOLETA DE COMPRA ===========",
            "Cliente: \(cliente.Nombre) \(cliente.Apellido) (\(carrito.categoria())) DNI: \(cliente.Dni)",
            raya
        ]
        for item in carrito.items {
            lineas.append(fila("\(item.producto.nombre) x\(item.cantidad)", soles(item.subtotal())))
        }
        lineas.append(raya)
        lineas.append(fila("Subtotal:", soles(carrito.subtotal())))
        lineas.append(fila("Descuento (\(porcentaje)%):", "-" + soles(carrito.montoDescuento())))
        lineas.append(fila("IGV (18%):", soles(carrito.igv())))
        lineas.append(fila("TOTAL:", soles(carrito.total())))
        lineas.append(doble)
        return lineas.joined(separator: "\n")
    }

    // Reto 1: al cerrar la boleta se vuelve directo al Catálogo.
    // Con la barra de pestañas, la modal se presenta desde el UITabBarController.
    @IBAction func cerrarTapped(_ sender: Any) {
        let presentador = presentingViewController
        let nav: UINavigationController?
        if let tabs = presentador as? UITabBarController {
            nav = tabs.selectedViewController as? UINavigationController
        } else {
            nav = (presentador as? UINavigationController) ?? presentador?.navigationController
        }
        dismiss(animated: true) {
            nav?.popToRootViewController(animated: false)
        }
    }
}
