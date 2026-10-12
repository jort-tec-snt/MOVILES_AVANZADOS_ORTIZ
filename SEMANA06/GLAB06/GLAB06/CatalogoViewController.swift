// Desarrollado por: Jeronimo Ortiz
import UIKit

class CatalogoViewController: UIViewController {

    let productos: [Producto] = [
        Producto(nombre: "Refrigeradora", precio: 2000, stock: 5),
        Producto(nombre: "Licuadora", precio: 250, stock: 10),
        Producto(nombre: "Laptop", precio: 3500, stock: 3),
        Producto(nombre: "Cocina", precio: 1200, stock: 4),
        Producto(nombre: "Microondas", precio: 450, stock: 6)
    ]

    // El carrito se crea UNA sola vez, aquí
    let carrito = CarritoModel()

    @IBOutlet weak var verCarritoButton: UIButton!

    // Se ejecuta cada vez que se vuelve a esta pantalla (a diferencia de viewDidLoad)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verCarritoButton.setTitle("Ver carrito (\(carrito.cantidadTotal()))", for: .normal)
    }

    // Los 4 botones de producto usan esta MISMA acción; elige el producto
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
