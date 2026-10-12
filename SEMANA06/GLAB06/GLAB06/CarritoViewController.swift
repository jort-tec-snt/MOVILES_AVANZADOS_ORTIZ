// Desarrollado por: Jeronimo Ortiz
import UIKit

class CarritoViewController: UIViewController {
    // Llega desde el Catálogo: es el MISMO objeto (Regla 2)
    var carrito: CarritoModel!

    @IBOutlet weak var lblLineas: UILabel!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblDescuento: UILabel!
    @IBOutlet weak var lblIGV: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblCategoria: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        aplicarTemaTienda()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refrescar()
    }

    // Solo muestra lo que calcula el modelo (Regla 5)
    private func refrescar() {
        if carrito.items.isEmpty {
            lblLineas.text = "El carrito está vacío"
        } else {
            lblLineas.text = carrito.items
                .map { "\($0.producto.nombre) x\($0.cantidad)  ·  \(soles($0.subtotal()))" }
                .joined(separator: "\n")
        }
        let porcentaje = Int((carrito.porcentajeDescuento() * 100).rounded())
        lblSubtotal.text = "Subtotal: \(soles(carrito.subtotal()))"
        lblDescuento.text = "Descuento (\(porcentaje)%): -\(soles(carrito.montoDescuento()))"
        lblIGV.text = "IGV (18%): \(soles(carrito.igv()))"
        lblTotal.text = "Total: \(soles(carrito.total()))"
        lblCategoria.text = "Categoría: \(carrito.categoria())"
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
