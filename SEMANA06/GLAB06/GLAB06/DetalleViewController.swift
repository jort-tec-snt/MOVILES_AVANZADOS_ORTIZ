// Desarrollado por: Jeronimo Ortiz
import UIKit

class DetalleViewController: UIViewController {
    // Llegan desde el Catálogo por prepare(for:sender:); sus IBOutlet aún son nil allí
    var producto: Producto!
    var carrito: CarritoModel!

    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblStock: UILabel!
    @IBOutlet weak var lblCantidad: UILabel!
    @IBOutlet weak var stepperCantidad: UIStepper!

    override func viewDidLoad() {
        super.viewDidLoad()
        lblNombre.text = producto.nombre
        lblPrecio.text = soles(producto.precio)
        stepperCantidad.minimumValue = 1
        stepperCantidad.maximumValue = 99
        stepperCantidad.value = 1
        lblCantidad.text = "1"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblStock.text = "\(producto.stock)"
    }

    @IBAction func cantidadCambiada(_ sender: UIStepper) {
        lblCantidad.text = "\(Int(sender.value))"
    }

    @IBAction func agregarTapped(_ sender: Any) {
        let cantidad = Int(stepperCantidad.value)
        if carrito.agregar(producto: producto, cantidad: cantidad) {
            mostrarAlerta("Agregado", "\(cantidad) x \(producto.nombre) en el carrito.")
            stepperCantidad.value = 1
            lblCantidad.text = "1"
        } else {
            let yaHay = carrito.items.first { $0.producto === producto }?.cantidad ?? 0
            mostrarAlerta("Stock insuficiente",
                          "Hay \(producto.stock) unidades de \(producto.nombre) y ya tienes \(yaHay) en el carrito.")
        }
    }
}
