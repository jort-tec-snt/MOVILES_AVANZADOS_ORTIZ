// xcode: set sdk=iOS

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfDni: UITextField!

    // Llega desde el Carrito por prepare(for:sender:) (Regla 2: el mismo carrito)
    var carrito: CarritoModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if carrito != nil {
            // Dentro del pago no se ofrece ir a otras pantallas
            navigationItem.rightBarButtonItem = nil
        }
    }

    // Regla 8: campos obligatorios y DNI de exactamente 8 dígitos, cada error con UIAlertController
    @IBAction func btnContinuar(_ sender: Any) {
        let apellido = (tfApellido.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let nombre = (tfNombre.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let dni = (tfDni.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        guard !apellido.isEmpty, !nombre.isEmpty, !dni.isEmpty else {
            mostrarAlerta("Campos obligatorios", "Completa apellido, nombre y DNI.")
            return
        }
        guard dni.count == 8, dni.allSatisfy({ $0.isASCII && $0.isNumber }) else {
            mostrarAlerta("DNI inválido", "El DNI debe tener exactamente 8 dígitos.")
            return
        }

        let oCliente = ClienteModel(pCodigo: 0, pApellido: apellido, pNombre: nombre, pDni: dni)
        performSegue(withIdentifier: "verBoleta", sender: oCliente)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verBoleta" {
            let destino = segue.destination as! BoletaViewController
            destino.carrito = carrito
            destino.cliente = sender as? ClienteModel
        }
    }
}
