import UIKit

class NuevaVentaViewController: UIViewController {
    @IBOutlet weak var tfElectrodomestico: UITextField!
    @IBOutlet weak var tfPrecioUnitario: UITextField!
    @IBOutlet weak var tfCantidad: UITextField!
    @IBOutlet weak var tfMeses: UITextField!
    @IBOutlet weak var tfTasaInteres: UITextField!

    private var ventaCalculada: VentaModel?

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
