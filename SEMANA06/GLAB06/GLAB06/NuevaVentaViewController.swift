import UIKit

class NuevaVentaViewController: UIViewController {
    @IBOutlet weak var tfElectrodomestico: UITextField!
    @IBOutlet weak var tfPrecioUnitario: UITextField!
    @IBOutlet weak var tfCantidad: UITextField!
    @IBOutlet weak var tfMeses: UITextField!
    @IBOutlet weak var tfTasaInteres: UITextField!
    @IBOutlet weak var cardVenta: UIView!

    private var ventaCalculada: VentaModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        let cobre = UIColor(red: 0.843, green: 0.631, blue: 0.416, alpha: 1)
        let texto = UIColor(red: 0.961, green: 0.945, blue: 0.910, alpha: 1)
        let secundario = UIColor(red: 0.753, green: 0.722, blue: 0.675, alpha: 1)
        let barra = UINavigationBarAppearance()
        barra.configureWithOpaqueBackground()
        barra.backgroundColor = UIColor(red: 0.082, green: 0.106, blue: 0.122, alpha: 1)
        barra.titleTextAttributes = [.foregroundColor: texto]
        barra.shadowColor = cobre.withAlphaComponent(0.3)
        navigationItem.standardAppearance = barra
        navigationItem.scrollEdgeAppearance = barra
        navigationItem.compactAppearance = barra

        cardVenta.layer.borderColor = cobre.withAlphaComponent(0.35).cgColor
        [tfElectrodomestico, tfPrecioUnitario, tfCantidad, tfMeses, tfTasaInteres].forEach { campo in
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
        navigationController?.navigationBar.tintColor = UIColor(red: 0.843, green: 0.631, blue: 0.416, alpha: 1)
    }

    @IBAction func calcular(_ sender: Any) {
        let nombre = tfElectrodomestico.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !nombre.isEmpty,
              let precio = Double((tfPrecioUnitario.text ?? "").replacingOccurrences(of: ",", with: ".")),
              precio.isFinite, precio > 0,
              let cantidad = Int(tfCantidad.text ?? ""), cantidad > 0,
              let meses = Int(tfMeses.text ?? ""), meses > 0,
              let tasa = Double((tfTasaInteres.text ?? "").replacingOccurrences(of: ",", with: ".")),
              tasa.isFinite, tasa >= 0 else {
            let alerta = UIAlertController(title: "Revisa los datos", message: "Ingresa un electrodoméstico, precio, cantidad y meses mayores que cero, e interés no negativo.", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
            present(alerta, animated: true)
            return
        }

        let venta = VentaModel()
        venta.subtotal = precio * Double(cantidad)
        venta.igv = venta.subtotal * 0.18
        venta.base = venta.subtotal + venta.igv
        venta.intereses = venta.base * (tasa / 100) * Double(meses)
        venta.total = venta.base + venta.intereses
        venta.cuota = venta.total / Double(meses)
        ventaCalculada = venta
        performSegue(withIdentifier: "showResultado", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultado",
           let resultado = segue.destination as? ResultadoVentaViewController {
            resultado.venta = ventaCalculada
        }
    }
}
