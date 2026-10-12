// Desarrollado por: Jeronimo Ortiz
import UIKit

class CatalogoViewController: UIViewController {

    // Prueba final (Regla 10): agregar el Microondas necesitó 2 cambios en total.
    //  - Storyboard: 1 cambio. Un botón nuevo con Tag 4 conectado a la misma acción
    //    productoTapped y a la colección productoButtons; no hay ningún segue nuevo.
    //  - Código: 1 cambio. Una línea nueva en el arreglo `productos`.
    // Todo lo demás (Detalle, Carrito, descuentos y boleta) funciona sin tocarse.
    // Los datos fijos del caso (Regla 1)
    let productos: [Producto] = [
        Producto(nombre: "Refrigeradora", precio: 2000, stock: 5),
        Producto(nombre: "Licuadora", precio: 250, stock: 10),
        Producto(nombre: "Laptop", precio: 3500, stock: 3),
        Producto(nombre: "Cocina", precio: 1200, stock: 4),
        Producto(nombre: "Microondas", precio: 450, stock: 6)
    ]

    // El carrito se crea UNA sola vez, aquí (Regla 2)
    let carrito = CarritoModel()

    @IBOutlet weak var verCarritoButton: UIButton!
    // Los 4 botones de producto (el Tag de cada uno es su posición en `productos`)
    @IBOutlet var productoButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        aplicarTemaTienda()
    }

    // Se ejecuta cada vez que se vuelve a esta pantalla (a diferencia de viewDidLoad)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(red: 0.925, green: 0.733, blue: 0.486, alpha: 1)
        verCarritoButton.setTitle("Ver carrito (\(carrito.cantidadTotal()))", for: .normal)
        actualizarProductos()
        // Insignia en la pestaña Tienda con lo que hay en el carrito
        let cantidad = carrito.cantidadTotal()
        navigationController?.tabBarItem.badgeValue = cantidad > 0 ? "\(cantidad)" : nil
    }

    // El stock se ve en cada botón y un producto sin stock queda deshabilitado
    private func actualizarProductos() {
        for boton in productoButtons {
            let producto = productos[boton.tag]
            if producto.stock > 0 {
                boton.setTitle("\(producto.nombre)  ·  \(soles(producto.precio))  ·  Stock \(producto.stock)", for: .normal)
                boton.isEnabled = true
            } else {
                boton.setTitle("\(producto.nombre)  ·  Agotado", for: .normal)
                boton.isEnabled = false
            }
        }
    }

    // Los 4 botones de producto usan esta MISMA acción; su Tag (0 a 3) elige el producto
    @IBAction func productoTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "verDetalle", sender: sender)
    }

    @IBAction func verCarritoTapped(_ sender: Any) {
        performSegue(withIdentifier: "verCarrito", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verDetalle" {
            let boton = sender as! UIButton
            let destino = segue.destination as! DetalleViewController
            destino.producto = productos[boton.tag] // elige el producto según el tag
            destino.carrito = carrito               // el MISMO objeto, no una copia
        } else if segue.identifier == "verCarrito" {
            let destino = segue.destination as! CarritoViewController
            destino.carrito = carrito
        }
    }
}
