import UIKit

class ResultadoVentaViewController: UIViewController {
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblIgv: UILabel!
    @IBOutlet weak var lblBase: UILabel!
    @IBOutlet weak var lblIntereses: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblCuota: UILabel!
    @IBOutlet weak var cardResultado: UIView!

    var venta: VentaModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        let cobre = UIColor(red: 0.843, green: 0.631, blue: 0.416, alpha: 1)
        let barra = UINavigationBarAppearance()
        barra.configureWithOpaqueBackground()
        barra.backgroundColor = UIColor(red: 0.082, green: 0.106, blue: 0.122, alpha: 1)
        barra.titleTextAttributes = [.foregroundColor: UIColor(red: 0.961, green: 0.945, blue: 0.910, alpha: 1)]
        barra.shadowColor = cobre.withAlphaComponent(0.3)
        navigationItem.standardAppearance = barra
        navigationItem.scrollEdgeAppearance = barra
        navigationItem.compactAppearance = barra
        cardResultado.layer.borderColor = cobre.withAlphaComponent(0.35).cgColor
        [lblSubtotal, lblIgv, lblBase, lblIntereses, lblTotal, lblCuota].forEach { valor in
            valor?.adjustsFontSizeToFitWidth = true
            valor?.minimumScaleFactor = 0.75
            valor?.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
        guard let venta = venta else { return }
        lblSubtotal.text = String(format: "S/. %.2f", venta.subtotal)
        lblIgv.text = String(format: "S/. %.2f", venta.igv)
        lblBase.text = String(format: "S/. %.2f", venta.base)
        lblIntereses.text = String(format: "S/. %.2f", venta.intereses)
        lblTotal.text = String(format: "S/. %.2f", venta.total)
        lblCuota.text = String(format: "S/. %.2f", venta.cuota)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(red: 0.843, green: 0.631, blue: 0.416, alpha: 1)
    }
}
