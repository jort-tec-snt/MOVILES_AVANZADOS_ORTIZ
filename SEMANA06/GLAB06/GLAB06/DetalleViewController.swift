// Desarrollado por: Jeronimo Ortiz
import UIKit

class DetalleViewController: UIViewController {
    // Llegan desde el Catálogo por prepare(for:sender:); sus IBOutlet aún son nil allí
    var producto: Producto!
    var carrito: CarritoModel!

    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblStock: UILabel!
    @IBOutlet weak var tfCantidad: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        aplicarTemaTienda()
        lblNombre.text = producto.nombre
        lblPrecio.text = "Precio: \(soles(producto.precio))"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblStock.text = "Stock disponible: \(producto.stock)"
    }

    @IBAction func agregarTapped(_ sender: Any) {
        view.endEditing(true)
        guard let cantidad = Int((tfCantidad.text ?? "").trimmingCharacters(in: .whitespaces)), cantidad > 0 else {
            mostrarAlerta("Cantidad inválida", "Ingresa un número entero mayor que 0.")
            return
        }
        if carrito.agregar(producto: producto, cantidad: cantidad) {
            mostrarAlerta("Agregado", "\(cantidad) x \(producto.nombre) en el carrito.")
        } else {
            let yaHay = carrito.items.first { $0.producto === producto }?.cantidad ?? 0
            mostrarAlerta("Stock insuficiente",
                          "Hay \(producto.stock) unidades de \(producto.nombre) y ya tienes \(yaHay) en el carrito.")
        }
    }
}
