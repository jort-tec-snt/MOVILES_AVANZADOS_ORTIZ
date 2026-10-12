// Desarrollado por: Jeronimo Ortiz
import UIKit

class BoletaViewController: UIViewController {
    // Llegan desde Datos del cliente por prepare(for:sender:)
    var carrito: CarritoModel!
    var cliente: ClienteModel!

    @IBOutlet weak var lblCliente: UILabel!
    @IBOutlet weak var stackDetalle: UIStackView!
    @IBOutlet weak var lblTotal: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Primero se arma la boleta con el carrito intacto; luego se confirma la compra (Regla 9)
        lblCliente.text = "\(cliente.Nombre) \(cliente.Apellido) (\(carrito.categoria())) · DNI \(cliente.Dni)"
        stackDetalle.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for item in carrito.items {
            stackDetalle.addArrangedSubview(
                filaDosColumnas("\(item.producto.nombre) x\(item.cantidad)", monto(item.subtotal())))
        }
        let porcentaje = Int((carrito.porcentajeDescuento() * 100).rounded())
        stackDetalle.addArrangedSubview(
            filaDosColumnas("Descuento (\(porcentaje)%)", "-" + monto(carrito.montoDescuento())))
        stackDetalle.addArrangedSubview(filaDosColumnas("IGV (18%)", monto(carrito.igv())))
        lblTotal.text = soles(carrito.total())
        carrito.confirmarCompra()
    }

    // Reto 1: al cerrar la boleta se vuelve directo al Catálogo
    @IBAction func cerrarTapped(_ sender: Any) {
        let presentador = presentingViewController
        let nav = (presentador as? UINavigationController) ?? presentador?.navigationController
        dismiss(animated: true) {
            nav?.popToRootViewController(animated: false)
        }
    }
}
