// xcode: set sdk=iOS

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfDni: UITextField!
    @IBOutlet weak var cardCliente: UIView!

    // Llega desde el Carrito por prepare(for:sender:) (Regla 2: el mismo carrito).
    // Si es nil, la pantalla se abrió desde la pestaña Clientes (registro suelto).
    var carrito: CarritoModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        if carrito != nil {
            // Dentro del pago: título propio y sin salidas a otras pantallas
            navigationItem.title = "Datos del cliente"
            navigationItem.largeTitleDisplayMode = .never
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
        }

        let cobre = UIColor(red: 0.925, green: 0.733, blue: 0.486, alpha: 1)
        let texto = UIColor(red: 0.961, green: 0.945, blue: 0.910, alpha: 1)
        let secundario = UIColor(red: 0.753, green: 0.722, blue: 0.675, alpha: 1)
        let barra = UINavigationBarAppearance()
        barra.configureWithOpaqueBackground()
        barra.backgroundColor = UIColor(red: 0.082, green: 0.106, blue: 0.122, alpha: 1)
        barra.titleTextAttributes = [.foregroundColor: texto]
        barra.largeTitleTextAttributes = [.foregroundColor: texto]
        barra.shadowColor = cobre.withAlphaComponent(0.3)
        navigationItem.standardAppearance = barra
        navigationItem.scrollEdgeAppearance = barra
        navigationItem.compactAppearance = barra
        navigationItem.leftBarButtonItem?.tintColor = cobre
        navigationItem.rightBarButtonItem?.tintColor = cobre
        let barButtonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: cobre,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(barButtonAttributes, for: .normal)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(barButtonAttributes, for: .highlighted)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(barButtonAttributes, for: .normal)

        cardCliente.layer.borderColor = cobre.withAlphaComponent(0.35).cgColor
        [tfApellido, tfNombre, tfDni].forEach { campo in
            campo?.layer.cornerRadius = 10
            campo?.layer.borderWidth = 1
            campo?.layer.borderColor = cobre.withAlphaComponent(0.3).cgColor
            campo?.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 1))
            campo?.leftViewMode = .always
            campo?.tintColor = cobre
            campo?.attributedPlaceholder = NSAttributedString(
                string: campo?.placeholder ?? "",
                attributes: [.foregroundColor: secundario]
            )
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(red: 0.925, green: 0.733, blue: 0.486, alpha: 1)
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

        if carrito == nil {
            // Pestaña Clientes: confirmación de registro (flujo original de la práctica)
            let oStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let oPantalla2 = oStoryboard.instantiateViewController(
                withIdentifier: "ViewControllerConfirmacion"
            ) as! ViewControllerConfirmacion
            oPantalla2.pCliente = oCliente
            present(oPantalla2, animated: true, completion: nil)
        } else {
            // Pago de la tienda: boleta modal con el mismo carrito
            performSegue(withIdentifier: "verBoleta", sender: oCliente)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verBoleta" {
            let destino = segue.destination as! BoletaViewController
            destino.carrito = carrito
            destino.cliente = sender as? ClienteModel
        }
    }
}
