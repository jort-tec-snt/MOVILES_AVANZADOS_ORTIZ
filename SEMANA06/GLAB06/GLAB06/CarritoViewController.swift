// Desarrollado por: Jeronimo Ortiz
import UIKit

class CarritoViewController: UIViewController {
    // Llega desde el Catálogo: es el MISMO objeto (Regla 2)
    var carrito: CarritoModel!

    @IBOutlet weak var stackLineas: UIStackView!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblDescuentoTitulo: UILabel!
    @IBOutlet weak var lblDescuento: UILabel!
    @IBOutlet weak var lblIGV: UILabel!
    @IBOutlet weak var lblTotal: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refrescar()
    }

    // Solo muestra lo que calcula el modelo (Regla 5)
    private func refrescar() {
        stackLineas.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if carrito.items.isEmpty {
            let vacio = UILabel()
            vacio.text = "El carrito está vacío"
            vacio.font = .systemFont(ofSize: 15)
            stackLineas.addArrangedSubview(vacio)
        }
        for item in carrito.items {
            stackLineas.addArrangedSubview(
                filaDosColumnas("\(item.producto.nombre) x\(item.cantidad)", monto(item.subtotal())))
        }
        let porcentaje = Int((carrito.porcentajeDescuento() * 100).rounded())
        lblSubtotal.text = monto(carrito.subtotal())
        lblDescuentoTitulo.text = "Descuento (\(porcentaje)%)"
        lblDescuento.text = "-" + monto(carrito.montoDescuento())
        lblIGV.text = monto(carrito.igv())
        lblTotal.text = monto(carrito.total())
    }

    @IBAction func continuarTapped(_ sender: Any) {
        guard !carrito.items.isEmpty else {
            mostrarAlerta("Carrito vacío", "Agrega al menos un producto antes de continuar.")
            return
        }
        performSegue(withIdentifier: "irDatosCliente", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irDatosCliente" {
            let destino = segue.destination as! ViewController
            destino.carrito = carrito
        }
    }
}
